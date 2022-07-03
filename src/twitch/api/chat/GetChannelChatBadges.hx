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
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "chat/badges";

  public static function call(client:Client, query:GetChannelChatBadgesQuery):APIResponse<GetChannelChatBadgesResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}