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
  static var scopeRequired = "";
  static var oauthRequired = true;
  static var method = HttpMethod.Get;
  static var endpoint = "chat/badges/global";

  public static function call(client:Client):APIResponse<GetGlobalChatBadgesResponse> {
    return APIEndpoint.call(method, endpoint, client);
  }
}