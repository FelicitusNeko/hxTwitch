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
  public static varscopeRequired = "channel:manage:raids";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Post;
  public static varendpoint = "raids";

  public static function call(client:Client, query:StartRaidQuery):APIResponse<StartRaidResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}