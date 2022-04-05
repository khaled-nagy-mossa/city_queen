import 'package:email_validator/email_validator.dart';

import '../../../common/const/app_data.dart';


class SignInModel {
  String email, password;

  Map<String, dynamic> toMap() {
    return <String ,dynamic>{
      'email': email,
      'password': password,
      'role': AppData.userRole,
    };
  }

  bool get validEmail {
    return emailValidator(email) == null;
  }

  bool get validPassword {
    return passwordValidator(password) == null;
  }

  String emailValidator(String value) {
    email = value;

    if (email == null) {
      return 'invalid email';
    } else {
      if (EmailValidator.validate(email)) {
        return null;
      } else {
        return 'invalid email';
      }
    }
  }

  String passwordValidator(String value) {
    password = value;

    if (password == null) {
      return 'invalid password!';
    } else {
      if (password.length >= 8) {
        return null;
      } else {
        return 'invalid password!';
      }
    }
  }
}
