import 'package:esya_app_mobile/api/models.dart';
import 'package:flutter/foundation.dart';

class UserContext extends ChangeNotifier {
  /// Internal, private state of the cart.
  User _user = defaultUser;

  bool get isLoggedIn => _user.userId > 0;
  int get userId => _user.userId;
  String get email => _user.email;
  String get userName => _user.userName;
  String get firstName => _user.firstName;
  String get lastName => _user.lastName;
  String get password => _user.password;
  String get profilePicture => _user.profilePicture;
  String get phoneNumber => _user.phoneNumber;
  bool get emailVerified => _user.emailVerified;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  void removeUser() {
    _user = defaultUser;
    notifyListeners();
  }
}
