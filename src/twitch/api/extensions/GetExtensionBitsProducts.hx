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
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "bits/extensions";

  public static function call(client:Client, query:GetExtensionsBitsProductsQuery):APIResponse<GetExtensionsBitsProductsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}