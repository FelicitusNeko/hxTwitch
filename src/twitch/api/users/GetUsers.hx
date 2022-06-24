package twitch.api.users;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetUsersQuery = {
  var ?id:String;
  var ?login:String;
}

typedef GetUsersRequest = {
}

typedef GetUsersResponse = Array<{
  var id:String;
  var login:String;
  var display_name:String;
  var type:String;
  var broadcaster_type:String;
  var description:String;
  var profile_image_url:String;
  var offline_image_url:String;
  var view_count:Int;
  var ?email:String;
  var created_at:String;
}>

class GetUsers extends APIEndpoint {
  public static varscopeRequired = null;
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "users";

  public static function call(client:Client, query:GetUsersQuery):APIResponse<GetUsersResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}