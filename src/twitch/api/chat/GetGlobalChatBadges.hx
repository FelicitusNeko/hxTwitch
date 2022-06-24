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
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "chat/badges/global";

  public static function call(client:Client):APIResponse<GetGlobalChatBadgesResponse> {
    return APIEndpoint.call(method, endpoint, client);
  }
}