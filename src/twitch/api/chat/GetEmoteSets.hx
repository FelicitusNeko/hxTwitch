package twitch.api.chat;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetEmoteSetsQuery = {
  var emote_set_id:String;
}

typedef GetEmoteSetsRequest = {
}

typedef GetEmoteSetsResponse = Array<{
  var id:String;
  var name:String;
  var images:URLScaleCollection;
  var emote_type:String;
  var emote_set_id:String;
  var owner_id:String;
  var format:Array<String>;
  var scale:Array<String>;
  var theme_mode:Array<String>;
}>

class GetEmoteSets extends APIEndpoint {
  static var scopeRequired = "";
  static var oauthRequired = true;
  static var method = HttpMethod.Get;
  static var endpoint = "chat/emotes/set";

  public static function call(client:Client, query:GetEmoteSetsQuery):APIResponse<GetEmoteSetsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}