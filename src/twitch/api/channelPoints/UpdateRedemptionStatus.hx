package twitch.api.channelPoints;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef UpdateRedemptionStatusQuery = {
	var id:String;
	var broadcaster_id:String;
	var reward_id:String;
}

typedef UpdateRedemptionStatusRequest = {
	var status:String;
}

typedef UpdateRedemptionStatusResponse = Array<{
	var broadcaster_id:String;
	var broadcaster_login:String;
	var broadcaster_name:String;
	var id:String;
	var user_id:String;
	var user_login:String;
	var user_name:String;
	var status:String;
	var redeemed_at:String;
	var reward:{
		var id:String;
		var title:String;
		var prompt:String;
		var cost:Int;
	};
}>

class UpdateRedemptionStatus extends APIEndpoint {
	public static var scopeRequired = "channel:manage:redemptions";
	public static var oauthRequired = true;
	public static var method = HttpMethod.Patch;
	public static var endpoint = "custom_rewards/redemptions";

	public static function call(client:Client, query:UpdateRedemptionStatusQuery,
			request:UpdateRedemptionStatusRequest):APIResponse<UpdateRedemptionStatusResponse> {
		return APIEndpoint.call(method, endpoint, client, cast(query, Map<String, Dynamic>), request);
	}
}
