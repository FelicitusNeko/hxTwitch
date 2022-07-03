package twitch.api.channelPoints;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetCustomRewardQuery = {
	var broadcaster:String;
  var ?id:String;
  var ?only_manageable_rewards:Bool;
}

typedef GetCustomRewardRequest = {
}

typedef GetCustomRewardResponse = Array<{
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

class GetCustomReward extends APIEndpoint {
  public static var scopeRequired = "channel:read:redemptions";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "channel_points/custom_rewards";

  public static function call(client:Client, query:GetCustomRewardQuery):APIResponse<GetCustomRewardResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}