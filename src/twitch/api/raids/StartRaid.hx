package twitch.api.raids;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef StartRaidQuery = {
  var from_broadcaster_id:String;
  var to_broadcaster_id:String;
}

typedef StartRaidRequest = {
}

typedef StartRaidResponse = Array<{
  var created_at:String;
  var is_mature:Bool;
}>

class StartRaid extends APIEndpoint {
  public static var scopeRequired = "channel:manage:raids";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Post;
  public static var endpoint = "raids";

  public static function call(client:Client, query:StartRaidQuery):APIResponse<StartRaidResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}