package twitch.api.channels;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetChannelInformationQuery = {
	var broadcaster_id:String;
}

typedef GetChannelInformationRequest = {}

typedef GetChannelInformationResponse = Array<{
	var broadcaster_id:String;
	var broadcaster_login:String;
	var broadcaster_name:String;
	var broadcaster_language:String;
	var game_id:String;
	var game_name:String;
	var title:String;
	var delay:Int;
}>

class GetChannelInformation extends APIEndpoint {
	public static varscopeRequired = null;
	public static varoauthRequired = false;
	public static varmethod = HttpMethod.Get;
	public static varendpoint = "channels";

	public static function call(client:Client, query:GetChannelInformationQuery):APIResponse<GetChannelInformationResponse> {
		return APIEndpoint.call(method, endpoint, client, query);
	}
}
