import '../../../common/config/api.dart';

abstract class AddressAPIs {
  const AddressAPIs();

  //to get all user addresses
  //type Post
  //params => no params
  static String getAddress = '${API.baseUrl}/get_address',
      //to add new address to user addresses list
      //type Post
      //params => no params
      addAddress = '${API.baseUrl}/add_address',
      //get all world countries
      //type get
      //params => no params
      getCountries = '${API.baseUrl}/get_countries',
      //get all States of country id
      //type get
      //params => no params
      getStates = '${API.baseUrl}/get_states';
}
