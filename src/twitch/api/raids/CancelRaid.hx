package twitch.api.raids;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef CancelRaidQuery = {
  var broadcaster_id:String;
}

typedef CancelRaidRequest = {
}

typedef CancelRaidResponse = {}

class CancelRaid extends APIEndpoint {
  public static varscopeRequired = "channel:manage:raids";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Delete;
  public static varendpoint = "raids";

  public static function call(client:Client, query:CancelRaidQuery):APIResponse<CancelRaidResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}