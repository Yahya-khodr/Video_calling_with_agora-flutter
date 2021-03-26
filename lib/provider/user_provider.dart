import 'package:chatting_with_mentors/models/user.dart';
import 'package:chatting_with_mentors/resources/auth_methods.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  Users _user;
  AuthMethods _authMethods = AuthMethods();

  Users get getUser => _user;

  void refreshUser() async {
    Users user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
