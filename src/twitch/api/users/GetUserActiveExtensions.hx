package twitch.api.users;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef ActiveExtension = {
  var active:Bool;
  var ?id:String;
  var ?version:String;
  var ?name:String;
  var ?x:Int;
  var ?y:Int;
}

typedef GetUserActiveExtensionsQuery = {
  var ?user_id:String;
}

typedef GetUserActiveExtensionsRequest = {
}

typedef GetUserActiveExtensionsResponse = Array<{
  var panel:Map<String, ActiveExtension>;
  var overlay:Map<String, ActiveExtension>;
  var component:Map<String, ActiveExtension>;
}>

class GetUserActiveExtensions extends APIEndpoint {
  public static var scopeRequired = "user:read:broadcast";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "users/extensions";

  public static function call(client:Client, query:GetUserActiveExtensionsQuery):APIResponse<GetUserActiveExtensionsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}