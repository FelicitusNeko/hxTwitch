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
  public static var scopeRequired = "channel:manage:raids";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Delete;
  public static var endpoint = "raids";

  public static function call(client:Client, query:CancelRaidQuery):APIResponse<CancelRaidResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}