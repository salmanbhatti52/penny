import 'package:penny_places/data/models/signin_model.dart';
import 'package:penny_places/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  Future<void> saveUserData(SignInModel model) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setString('userID', model.data!.usersCustomersId.toString());
    await prefs!.setString('userName', model.data!.userName);
    await prefs!.setString('email', model.data!.email);
    await prefs!.setString('profilePicture', model.data!.profilePicture ?? '');
    await prefs!.setString('bio', model.data!.profileBio ?? '');
  }
}
