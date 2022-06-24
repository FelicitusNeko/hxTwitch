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
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "bits/extensions";

  public static function call(client:Client, query:GetExtensionsBitsProductsQuery):APIResponse<GetExtensionsBitsProductsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}