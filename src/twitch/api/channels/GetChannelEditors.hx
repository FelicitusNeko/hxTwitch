package twitch.api.channels;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetChannelEditorsQuery = {
  var broadcaster_id:String;
}

typedef GetChannelEditorsRequest = {
}

typedef GetChannelEditorsResponse = Array<{
  var user_id:String;
  var user_name:String;
  var created_at:String;
}>

class GetChannelEditors extends APIEndpoint {
  static var scopeRequired = "channel:read:editors";
  static var oauthRequired = true;
  static var method = HttpMethod.Get;
  static var endpoint = "channels/editors";

	public static function call(client:Client, query:GetChannelEditorsQuery):APIResponse<GetChannelEditorsResponse> {
		return APIEndpoint.call(method, endpoint, client, query);
	}
}