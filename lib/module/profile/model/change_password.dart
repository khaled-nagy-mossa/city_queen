class ChangePasswordModel {
  String oldPassword, newPassword, confirmPassword;

  Map<String, dynamic> toMap() {
    return Map<String, dynamic>.from(
      <String ,dynamic>{
        'old_password': oldPassword,
        'new_password': newPassword,
      },
    );
  }

  //validations
  String oldPasswordValidator(String value) {
    if (value == null || value.isEmpty) return 'Wrong Value';
    return null;
  }

  String newPasswordValidator(String value) {
    if (value == null || value.isEmpty) return 'Wrong Value';
    if (value.length < 6) return '6 char at least';
    return null;
  }

  String confirmPasswordValidator(String value) {
    if (value == null || value.isEmpty) return 'Wrong Value';
    if (value.length < 6) return '6 char at least';
    if (value != newPassword) return 'Password does not match';
    return null;
  }
}
