package twitch.api.chat;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;
import twitch.api.URLScaleCollection;

typedef GetChannelEmotesQuery = {
	var broadcaster_id:String;
}

typedef GetChannelEmotesRequest = {}

typedef GetChannelEmotesResponse = Array<{
	var id:String;
	var name:String;
	var images:URLScaleCollection;
	var tier:String;
	var emote_type:String;
	var emote_set_id:String;
	var format:Array<String>;
	var scale:Array<String>;
	var theme_mode:Array<String>;
}>

class GetChannelEmotes extends APIEndpoint {
	static var scopeRequired = null;
	static var oauthRequired = true;
	static var method = HttpMethod.Get;
	static var endpoint = "chat/emotes";

	public static function call(client:Client, query:GetChannelEmotesQuery):APIResponse<GetChannelEmotesResponse> {
		return APIEndpoint.call(method, endpoint, client, query);
	}
}
