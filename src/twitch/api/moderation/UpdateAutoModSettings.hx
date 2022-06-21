package twitch.api.moderation;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef UpdateAutoModSettingsQuery = {
	var broadcaster_id:String;
	var moderator_id:String;
}

typedef UpdateAutoModSettingsRequest = {
	var ?overall_level:Int;
	var ?disability:Int;
	var ?aggression:Int;
	var ?sexuality_sex_or_gender:Int;
	var ?misogyny:Int;
	var ?bullying:Int;
	var ?swearing:Int;
	var ?race_ethnicity_or_religion:Int;
	var ?sex_based_terms:Int;
}

typedef UpdateAutoModSettingsResponse = Array<{
	var broadcaster_id:String;
	var moderator_id:String;
	var ?overall_level:Int;
	var disability:Int;
	var aggression:Int;
	var sexuality_sex_or_gender:Int;
	var misogyny:Int;
	var bullying:Int;
	var swearing:Int;
	var race_ethnicity_or_religion:Int;
	var sex_based_terms:Int;
}>

class UpdateAutoModSettings extends APIEndpoint {
	static var scopeRequired = "moderator:manage:automod_settings";
	static var oauthRequired = true;
	static var method = HttpMethod.Put;
	static var endpoint = "moderation/automod/settings";

	public static function call(client:Client, query:UpdateAutoModSettingsQuery,
			request:UpdateAutoModSettingsRequest):APIResponse<UpdateAutoModSettingsResponse> {
		return APIEndpoint.call(method, endpoint, client, cast(query, Map<String, Dynamic>), request);
	}
}
