package twitch.api.chat;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetGlobalEmotesQuery = {
}

typedef GetGlobalEmotesRequest = {
}

typedef GetGlobalEmotesResponse = Array<{
  var id:String;
  var name:String;
  var images:URLScaleCollection;
  var format:Array<String>;
  var scale:Array<String>;
  var theme_mode:Array<String>;
}>

class GetGlobalEmotes extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "chat/emotes/global";

  public static function call(client:Client):APIResponse<GetGlobalEmotesResponse> {
    return APIEndpoint.call(method, endpoint, client);
  }
}