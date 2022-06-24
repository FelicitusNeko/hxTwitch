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
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "entitlements/codes";

  public static function call(client:Client, query:GetCodeStatusQuery):APIResponse<GetCodeStatusResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}