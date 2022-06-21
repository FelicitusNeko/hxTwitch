package twitch.api.entitlements;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetDropsEntitlementsQuery = {
  var ?id:String;
  var ?user_id:String;
  var ?game_id:String;
  var ?fulfillment_status:String;
  var ?after:String;
  var ?first:String;
}

typedef GetDropsEntitlementsRequest = {
}

typedef GetDropsEntitlementsResponse = Array<{
  var id:String;
  var benefit_id:String;
  var timestamp:String;
  var user_id:String;
  var game_id:String;
  var fulfillment_status:String;
  var updated_at:String;
}>

class GetDropsEntitlements extends APIEndpoint {
  static var scopeRequired = "";
  static var oauthRequired = true;
  static var method = HttpMethod.Get;
  static var endpoint = "entitlements/drops";

  public static function call(client:Client, query:GetDropsEntitlementsQuery):APIResponse<GetDropsEntitlementsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}