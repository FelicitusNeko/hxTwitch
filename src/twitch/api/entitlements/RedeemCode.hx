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
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Post;
  public static var endpoint = "entitlements/codes";

  public static function call(client:Client, query:RedeemCodeQuery):APIResponse<RedeemCodeResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}