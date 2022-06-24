package twitch.api.chat;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef UpdateChatSettingsQuery = {
	var broadcaster_id:String;
	var moderator_id:String;
}

typedef UpdateChatSettingsRequest = {
	var ?slow_mode:Bool;
	var ?slow_mode_wait_time:Int;
	var ?follower_mode:Bool;
	var ?follower_mode_duration:Int;
	var ?subscriber_mode:Bool;
	var ?emote_mode:Bool;
	var ?unique_chat_mode:Bool;
	var ?non_moderator_chat_delay:Bool;
	var ?non_moderator_chat_delay_duration:Int;
}

typedef UpdateChatSettingsResponse = Array<{
	var broadcaster_id:String;
	var moderator_id:String;
	var slow_mode:Bool;
	var ?slow_mode_wait_time:Int;
	var follower_mode:Bool;
	var ?follower_mode_duration:Int;
	var subscriber_mode:Bool;
	var emote_mode:Bool;
	var unique_chat_mode:Bool;
	var non_moderator_chat_delay:Bool;
	var ?non_moderator_chat_delay_duration:Int;
}>

class UpdateChatSettings extends APIEndpoint {
	public static varscopeRequired = "moderator:manage:chat_settings";
	public static varoauthRequired = true;
	public static varmethod = HttpMethod.Patch;
	public static varendpoint = "chat/settings";

	public static function call(client:Client, query:UpdateChatSettingsQuery, request:UpdateChatSettingsRequest):APIResponse<UpdateChatSettingsResponse> {
		return APIEndpoint.call(method, endpoint, client, cast(query, Map<String, Dynamic>), request);
	}
}
