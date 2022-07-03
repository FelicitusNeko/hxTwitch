package twitch.api.channels;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef ModifyChannelInformationQuery = {
  var broadcaster_id:String;
}

typedef ModifyChannelInformationRequest = {
  var ?game_id:String;
  var ?broadcaster_language:String;
  var ?title:String;
  var ?delay:Int;
}

typedef ModifyChannelInformationResponse = {}

class ModifyChannelInformation extends APIEndpoint {
  public static var scopeRequired = "channel:manage:broadcast";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Patch;
  public static var endpoint = "channels";

	public static function call(client:Client, query:ModifyChannelInformationQuery, data:ModifyChannelInformationRequest):APIResponse<ModifyChannelInformationResponse> {
		return APIEndpoint.call(method, endpoint, client, query);
	}
}