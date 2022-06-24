package twitch.api.entitlements;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef UpdateDropsEntitlementsQuery = {
}

typedef UpdateDropsEntitlementsRequest = {
  var entitlement_ids:Array<String>;
  var fulfillment_status:String;
}

typedef UpdateDropsEntitlementsResponse = Array<{
  var status:String;
  var ids:Array<String>;
}>

class UpdateDropsEntitlements extends APIEndpoint {
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Patch;
  public static varendpoint = "entitlements/drops";

  public static function call(client:Client, request:UpdateDropsEntitlementsRequest):APIResponse<UpdateDropsEntitlementsResponse> {
    return APIEndpoint.call(method, endpoint, client, [], request);
  }
}