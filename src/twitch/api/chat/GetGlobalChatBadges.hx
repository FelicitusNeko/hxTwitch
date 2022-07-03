package twitch.api.chat;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;
import twitch.api.URLScaleCollection;

typedef GetGlobalChatBadgesQuery = {
}

typedef GetGlobalChatBadgesRequest = {
}

typedef GetGlobalChatBadgesResponse = Array<{
  var set_id:String;
  var versions:Array<URLScaleAndIdCollection>;
}>

class GetGlobalChatBadges extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "chat/badges/global";

  public static function call(client:Client):APIResponse<GetGlobalChatBadgesResponse> {
    return APIEndpoint.call(method, endpoint, client);
  }
}