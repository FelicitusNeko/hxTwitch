package twitch.api.search;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef SearchCategoriesQuery = {
  var query:String;
  var ?first:Int;
  var ?after:String;
}

typedef SearchCategoriesRequest = {
}

typedef SearchCategoriesResponse = Array<{
  var id:String;
  var name:String;
  var box_art_url:String;
}>

class SearchCategories extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "search/categories";

  public static function call(client:Client, query:SearchCategoriesQuery):APIResponse<SearchCategoriesResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}