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
  public static varscopeRequired = "channel:manage:broadcast";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Patch;
  public static varendpoint = "channels";

	public static function call(client:Client, query:ModifyChannelInformationQuery, data:ModifyChannelInformationRequest):APIResponse<ModifyChannelInformationResponse> {
		return APIEndpoint.call(method, endpoint, client, query);
	}
}