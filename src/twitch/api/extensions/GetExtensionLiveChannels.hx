package twitch.api.extensions;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetExtensionLiveChannelsQuery = {
  var extension_id:String;
  var ?first:Int;
  var ?after:String;
}

typedef GetExtensionLiveChannelsRequest = {
}

typedef GetExtensionLiveChannelsResponse = Array<{
  var broadcaster_id:String;
  var broadcaster_name:String;
  var game_name:String;
  var game_id:String;
  var title:String;
}>

class GetExtensionLiveChannels extends APIEndpoint {
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "extensions/live";

  public static function call(client:Client, query:GetExtensionLiveChannelsQuery):APIResponse<GetExtensionLiveChannelsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}