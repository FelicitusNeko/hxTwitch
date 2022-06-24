package twitch.api.users;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef UpdateUserQuery = {
  var ?description:String;
}

typedef UpdateUserRequest = {
}

typedef UpdateUserResponse = Array<{
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

class UpdateUser extends APIEndpoint {
  public static varscopeRequired = "user:edit";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Put;
  public static varendpoint = "users";

  public static function call(client:Client, query:UpdateUserQuery):APIResponse<UpdateUserResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}