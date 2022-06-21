package twitch.api.moderation;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetAutoModSettingsQuery = {
  var broadcaster_id:String;
  var moderator_id:String;
}

typedef GetAutoModSettingsRequest = {
}

typedef GetAutoModSettingsResponse = Array<{
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

class GetAutoModSettings extends APIEndpoint {
  static var scopeRequired = "moderator:read:automod_settings";
  static var oauthRequired = true;
  static var method = HttpMethod.Get;
  static var endpoint = "moderation/automod/settings";

  public static function call(client:Client, query:GetAutoModSettingsQuery):APIResponse<GetAutoModSettingsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}