import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/profile_model.dart';

class ProfileViewModel extends Notifier<ProfileModel> {
  @override
  build() {
    return ProfileModel(
      inputName: "",
      inputBirthday: "",
    );
  }

  void setInputName(String name) {
    state = ProfileModel(inputName: name, inputBirthday: state.inputBirthday);
  }

  void setInputBirthday(String birthday) {
    state = ProfileModel(inputName: state.inputName, inputBirthday: birthday);
  }
}

final profileViewModel =
    NotifierProvider<ProfileViewModel, ProfileModel>(() => ProfileViewModel());
