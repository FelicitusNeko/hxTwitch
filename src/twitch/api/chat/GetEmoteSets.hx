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
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "chat/emotes/set";

  public static function call(client:Client, query:GetEmoteSetsQuery):APIResponse<GetEmoteSetsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}