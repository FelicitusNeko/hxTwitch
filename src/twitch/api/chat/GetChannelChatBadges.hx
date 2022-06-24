package twitch.api.chat;

import twitch.api.URLScaleCollection;
import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetChannelChatBadgesQuery = {
  var broadcaster_id:String;
}

typedef GetChannelChatBadgesRequest = {
}

typedef GetChannelChatBadgesResponse = Array<{
  var set_id:String;
  var versions:Array<URLScaleAndIdCollection>;
}>

class GetChannelChatBadges extends APIEndpoint {
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "chat/badges";

  public static function call(client:Client, query:GetChannelChatBadgesQuery):APIResponse<GetChannelChatBadgesResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}