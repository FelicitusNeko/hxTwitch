package twitch.api.streams;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetStreamKeyQuery = {
  var broadcaster_id:String;
}

typedef GetStreamKeyRequest = {
}

typedef GetStreamKeyResponse = Array<{
  var stream_key:String;
}>

class GetStreamKey extends APIEndpoint {
  public static var scopeRequired = "channel:read:stream_key";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "streams/key";

  public static function call(client:Client, query:GetStreamKeyQuery):APIResponse<GetStreamKeyResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}