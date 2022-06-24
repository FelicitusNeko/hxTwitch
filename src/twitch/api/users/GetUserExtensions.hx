package twitch.api.users;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetUserExtensionsQuery = {
}

typedef GetUserExtensionsRequest = {
}

typedef GetUserExtensionsResponse = Array<{
  var id:String;
  var version:String;
  var name:String;
  var can_activate:Bool;
  var type:Array<String>;
}>

class GetUserExtensions extends APIEndpoint {
  public static var scopeRequired = "user:read:broadcast";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "users/extensions/list";

  public static function call(client:Client):APIResponse<GetUserExtensionsResponse> {
    return APIEndpoint.call(method, endpoint, client);
  }
}