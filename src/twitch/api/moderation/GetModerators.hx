package twitch.api.moderation;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetModeratorsQuery = {
  var broadcaster_id:String;
  var ?user_id:String;
  var ?first:String;
  var ?after:String;
}

typedef GetModeratorsRequest = {
}

typedef GetModeratorsResponse = Array<{
  var user_id:String;
  var user_login:String;
  var user_name:String;
}>

class GetModerators extends APIEndpoint {
  public static var scopeRequired = "moderation:read";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "moderation/moderators";

  public static function call(client:Client, query:GetModeratorsQuery):APIResponse<GetModeratorsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}