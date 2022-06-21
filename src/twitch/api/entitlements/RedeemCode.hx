package twitch.api.entitlements;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef RedeemCodeQuery = {
  var code:String;
  var user_id:String;
}

typedef RedeemCodeRequest = {
}

typedef RedeemCodeResponse = Array<{
  var code:String;
  var status:String;
}>

class RedeemCode extends APIEndpoint {
  static var scopeRequired = "";
  static var oauthRequired = true;
  static var method = HttpMethod.Post;
  static var endpoint = "entitlements/codes";

  public static function call(client:Client, query:RedeemCodeQuery):APIResponse<RedeemCodeResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}