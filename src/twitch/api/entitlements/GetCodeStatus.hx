package twitch.api.entitlements;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetCodeStatusQuery = {
  var code:String;
  var user_id:String;
}

typedef GetCodeStatusRequest = {
}

typedef GetCodeStatusResponse = Array<{
  var code:String;
  var status:String;
}>

class GetCodeStatus extends APIEndpoint {
  static var scopeRequired = "";
  static var oauthRequired = true;
  static var method = HttpMethod.Get;
  static var endpoint = "entitlements/codes";

  public static function call(client:Client, query:GetCodeStatusQuery):APIResponse<GetCodeStatusResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}