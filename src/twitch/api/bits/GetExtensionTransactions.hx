package twitch.api.bits;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetExtensionTransactionsQuery = {
	var extension_id:String;
	var ?id:String;
	var ?after:String;
	var ?first:String;
}

typedef GetExtensionTransactionsRequest = {}

typedef GetExtensionTransactionsResponse = Array<{
	var id:String;
	var timestamp:String;
	var broadcaster_id:String;
	var broadcaster_login:String;
	var broadcaster_name:String;
	var user_id:String;
	var user_login:String;
	var user_name:String;
	var product_type:String;
	var product_data:{
		var domain:String;
		var sku:String;
		var cost:{
			var amount:Int;
			var type:String;
		};
		var inDevelopment:Bool;
		var displayName:String;
		var expiration:String;
		var broadcast:Bool;
	};
}>

class GetExtensionTransactions extends APIEndpoint {
	static var scopeRequired = null;
	static var oauthRequired = false;
	static var method = HttpMethod.Get;
	static var endpoint = "extensions/transactions";

	public static function call(client:Client, query:GetExtensionTransactionsQuery):APIResponse<GetExtensionTransactionsResponse> {
		return APIEndpoint.call(method, endpoint, client, query);
	}
}
