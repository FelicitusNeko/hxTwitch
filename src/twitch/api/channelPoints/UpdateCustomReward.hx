package twitch.api.channelPoints;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef UpdateCustomRewardQuery = {
	var broadcaster_id:String;
	var id:String;
}

typedef UpdateCustomRewardRequest = {
	var ?title:String;
	var ?prompt:String;
	var ?cost:Int;
	var ?is_enabled:Bool;
	var ?background_color:String;
	var ?is_user_input_required:String;
	var ?is_max_per_stream_enabled:Bool;
	var ?max_per_stream:Int;
	var ?is_max_per_user_per_stream_enabled:Bool;
	var ?max_per_user_per_stream:Int;
	var ?is_global_cooldown_enabled:Bool;
	var ?global_cooldown_seconds:Int;
	var ?is_paused:Bool;
	var ?should_redemptions_skip_request_queue:Bool;
}

typedef UpdateCustomRewardResponse = Array<{
	var broadcaster_name:String;
	var broadcaster_login:String;
	var broadcaster_id:String;
	var id:String;
	var ?image:URLScaleCollection;
	var background_color:String;
	var is_enabled:Bool;
	var cost:Int;
	var title:String;
	var prompt:String;
	var is_user_input_required:Bool;
	var max_per_stream_setting:{
		var is_enabled:Bool;
		var max_per_stream:Int;
	};
	var max_per_user_per_stream_setting:{
		var is_enabled:Bool;
		var max_per_user_per_stream:Int;
	};
	var global_cooldown_setting:{
		var is_enabled:Bool;
		var global_cooldown_seconds:Int;
	};
	var is_paused:Bool;
	var is_in_stock:Bool;
	var default_image:URLScaleCollection;
	var should_redemptions_skip_request_queue:Bool;
	var ?redemptions_redeemed_current_stream:Int;
	var ?cooldown_expires_at:String;
}>

class UpdateCustomReward extends APIEndpoint {
	public static var scopeRequired = "channel:manage:redemptions";
	public static var oauthRequired = true;
	public static var method = HttpMethod.Patch;
	public static var endpoint = "channel_points/custom_rewards";

	public static function call(client:Client, query:UpdateCustomRewardQuery, request:UpdateCustomRewardRequest):APIResponse<UpdateCustomRewardResponse> {
		return APIEndpoint.call(method, endpoint, client, cast(query, Map<String, Dynamic>), request);
	}
}
