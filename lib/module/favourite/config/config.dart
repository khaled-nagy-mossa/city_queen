import '../../../common/config/api.dart';

abstract class FavouriteAPIs {
  const FavouriteAPIs();

  //to add variant to favourites
  //type post
  //params => no params
  static String addToFavorites = '${API.baseUrl}/add_to_favorites',
      //to get favourite user variants
      //type post
      //params => no params
      favorites = '${API.baseUrl}/favorites',
      //to remove variant from favourite list
      //type post
      //params => no params
      removeFavorites = '${API.baseUrl}/remove_favorite';
}
