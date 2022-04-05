import 'package:email_validator/email_validator.dart';
import '../../../common/const/app_data.dart';
import '../../address/model/country.dart';
import '../../address/model/state.dart';

class SignUpModel {
  String name, email, phone, password, confirmPassword;
  Country country;
  StateLocation state;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'country_id': country.id,
      'state_id': state.id,
      'role': AppData.userRole
    };
  }

  bool get validEmail {
    return emailValidator(email) == null;
  }

  bool get validPassword {
    return passwordValidator(password) == null;
  }

  bool get validConfirmPassword {
    return confirmPasswordValidator(confirmPassword) == null;
  }

  String nameValidator(String value) {
    name = value;
    if (name == null || name.isEmpty) return 'invalid value';
    if (name.length <= 3) return 'must be more 3 char';
    return null;
  }

  String emailValidator(String value) {
    email = value;

    if (email == null) {
      return 'invalid email';
    } else {
      if (EmailValidator.validate(email ?? '')) {
        return null;
      } else {
        return 'invalid email';
      }
    }
  }

  String phoneValidator(String value) {
    phone = value;
    if (value == null || value.isEmpty) {
      return 'Phone number must be entered';
    } else if (value.length != 11) return 'phone not valid';
    return null;
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

  String confirmPasswordValidator(String value) {
    confirmPassword = value;
    if (confirmPassword.toString() != password.toString()) {
      return 'Password does not match';
    }
    return null;
  }
}
