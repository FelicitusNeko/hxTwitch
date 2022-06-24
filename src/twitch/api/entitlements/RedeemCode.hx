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
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Post;
  public static varendpoint = "entitlements/codes";

  public static function call(client:Client, query:RedeemCodeQuery):APIResponse<RedeemCodeResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}