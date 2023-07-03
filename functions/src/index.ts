import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();

export const onVideoCreated = functions.firestore
.document("videos/{videoId}")
.onCreate(async (snapshot, context) => {
    const spawn = require('child-process-promise').spawn;
    const video = snapshot.data();
    const [file, _] = await spawn("ffmpeg", [
        "-i",
        video.fileUrl,
        "-ss",
        "00:00:01.000",
        "-vframes",
        "1",
        "-vf",
        "scale=150:-1",
        `/tmp/${snapshot.id}.jpg`
    ]);
    const storage = admin.storage();
    await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
        destination: `thumbnail/${snapshot.id}.jpg`,
    });
    await file.makePublic();
    await snapshot.ref.update({thumbnailUrl: file.publicUrl()})
    // await snapshot.ref.update({"hello": "from functions"})

    const db = admin.firestore();
    await db.collection("users").doc(video.creatorUid).collection("videos").doc(snapshot.id).set({
        thumbnailUrl: file.publicUrl(),
        videoId: snapshot.id,
    });
});

export const onLikedCreated = functions.firestore.document("/likes/{likeId}").onCreate(async(snapshot, context)=> {
    const db = admin.firestore();
    const [videoId, _] = snapshot.id.split("000");
    await db.collection("videos").doc(videoId).update({
        likes: admin.firestore.FieldValue.increment(1),
    });
    const video = (await db.collection("videos").doc(videoId).get()).data();
    if(video) {
        const creatorUid = video.creatorUid;
        const user = (await db.collection("users").doc(creatorUid).get()).data();
        if(user) {
            const token = user.token;
            admin.messaging().sendToDevice(token, {
                data: {
                    "screen": "123",
                }, 
                notification: {
                    title: "someone like your video",
                    body: "Likes + 1 ! Congrats"
                }
            })
        }

    }
})

export const onLikedRemoved = functions.firestore.document("/likes/{likeId}").onDelete(async(snapshot, context)=> {
    const db = admin.firestore();
    const [videoId, _] = snapshot.id.split("000");
    await db.collection("videos").doc(videoId).update({
        likes: admin.firestore.FieldValue.increment(-1),
    })
})