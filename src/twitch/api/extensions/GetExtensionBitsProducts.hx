package twitch.api.extensions;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetExtensionsBitsProductsQuery = {
  var ?should_include_all:Bool;
}

typedef GetExtensionsBitsProductsRequest = {
}

typedef GetExtensionsBitsProductsResponse = Array<{
  var sku:String;
  var cost:{
    var amount:Int;
    var type:String;
  };
  var in_development:Bool;
  var display_name:String;
  var expiration:String;
  var is_broadcast:Bool;
}>

class GetExtensionsBitsProducts extends APIEndpoint {
  static var scopeRequired = "";
  static var oauthRequired = true;
  static var method = HttpMethod.Get;
  static var endpoint = "bits/extensions";

  public static function call(client:Client, query:GetExtensionsBitsProductsQuery):APIResponse<GetExtensionsBitsProductsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}