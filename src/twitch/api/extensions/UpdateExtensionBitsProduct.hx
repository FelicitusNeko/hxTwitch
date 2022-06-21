package twitch.api.extensions;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef UpdateExtensionBitsProductQuery = {}

typedef UpdateExtensionBitsProductRequest = {
  var sku:String;
  var cost:{
    var amount:Int;
    var type:String;
  };
  var display_name:String;
  var ?in_development:Bool;
  var ?in_broadcast:Bool;
  var ?expiration:String;
}

typedef UpdateExtensionBitsProductResponse = Array<{
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

class UpdateExtensionBitsProduct extends APIEndpoint {
	static var scopeRequired = "";
	static var oauthRequired = true;
	static var method = HttpMethod.Put;
	static var endpoint = "bits/extensions";

	public static function call(client:Client, request:UpdateExtensionBitsProductRequest):APIResponse<UpdateExtensionBitsProductResponse> {
		return APIEndpoint.call(method, endpoint, client, [], request);
	}
}
