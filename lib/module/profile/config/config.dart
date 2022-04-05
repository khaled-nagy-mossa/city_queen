import '../../../common/config/api.dart';

abstract class ProfileAPIs {
  const ProfileAPIs();

  //to change user account password
  //type post
  //params => no params
  static String changePassword = '${API.baseUrl}/change_password',
      //to get account details
      //type get
      //params => no params
      profileDetails = '${API.baseUrl}/profile_details',
      //to update account data (such as name phone)
      //type post
      //params => no params
      editProfile = '${API.baseUrl}/update_profile',
      //to upload user account image
      //type post
      //params => no params
      uploadAvatar = '${API.baseUrl}/upload_avatar';
}
