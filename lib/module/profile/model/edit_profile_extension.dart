import 'package:email_validator/email_validator.dart';

import 'edit_profile.dart';

extension EditProfileModelExtension on EditProfileModel {
  String nameValidator(String value) {
    if (name == null || name.isEmpty) return 'invalid value';
    if (name.length <= 3) return 'must be more 3 char';
    return null;
  }

  String emailValidator(String value) {
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

  String phoneValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'Phone number must be entered';
    } else if (value.length != 11) return 'phone not valid';
    return null;
  }
}
