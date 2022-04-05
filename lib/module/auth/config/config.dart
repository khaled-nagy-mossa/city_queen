import '../../../common/config/api.dart';

abstract class AuthAPIs {
  const AuthAPIs();

  // Auth ######################################################################
  //to sign in
  //type post
  //params => no params
  static String signIn = '${API.baseUrl}/login',
      //to sign up
      //type post
      //params => no params
      signUp = '${API.baseUrl}/register',
      //to send mail to user email when he forget password
      //type post
      //params => no params
      forgetPassword = '${API.baseUrl}/forget_password';
}
