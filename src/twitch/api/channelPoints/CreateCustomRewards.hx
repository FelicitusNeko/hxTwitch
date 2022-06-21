package twitch.api.channelPoints;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;
import twitch.api.URLScaleCollection;

typedef CreateCustomRewardsQuery = {
	var broadcaster_id:String;
}

typedef CreateCustomRewardsRequest = {
	var title:String;
	var cost:Int;
	var ?prompt:String;
	var ?is_enabled:Bool;
	var ?background_color:String;
	var ?is_user_input_required:String;
	var ?is_max_per_stream_enabled:Bool;
	var ?max_per_stream:Int;
	var ?is_max_per_user_per_stream_enabled:Bool;
	var ?max_per_user_per_stream:Int;
	var ?is_global_cooldown_enabled:Bool;
	var ?global_cooldown_seconds:Int;
	var ?should_redemptions_skip_request_queue:Bool;
}

typedef CreateCustomRewardsResponse = Array<{
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

class CreateCustomRewards extends APIEndpoint {
	static var scopeRequired = "channel:manage:redemptions";
	static var oauthRequired = true;
	static var method = HttpMethod.Post;
	static var endpoint = "channel_points/custom_rewards";

	public static function call(client:Client, query:CreateCustomRewardsQuery, request:CreateCustomRewardsRequest):APIResponse<CreateCustomRewardsResponse> {
		return APIEndpoint.call(method, endpoint, client, cast(query, Map<String, Dynamic>), request);
	}
}
