package twitch.api.chat;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetChatSettingsQuery = {
  var broadcaster_id:String;
  var ?moderator_id:String;
}

typedef GetChatSettingsRequest = {
}

typedef GetChatSettingsResponse = Array<{
  var broadcaster_id:String;
  var slow_mode:Bool;
  var ?slow_mode_wait_time:Int;
  var follower_mode:Bool;
  var ?follower_mode_duration:Int;
  var subscriber_mode:Bool;
  var emote_mode:Bool;
  var unique_chat_mode:Bool;
  var ?moderator_id:String;
  var ?non_moderator_chat_delay:Bool;
  var ?non_moderator_chat_delay_duration:Int;
}>

class GetChatSettings extends APIEndpoint {
  public static var scopeRequired = "moderator:read:chat_settings";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "chat/settings";

  public static function call(client:Client, query:GetChatSettingsQuery):APIResponse<GetChatSettingsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}