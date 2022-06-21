package twitch.api.moderation;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef ManageHeldAutoModMessagesQuery = {
}

typedef ManageHeldAutoModMessagesRequest = {
  var user_id:String;
  var msg_id:String;
  var action:String;
}

typedef ManageHeldAutoModMessagesResponse = {}

class ManageHeldAutoModMessages extends APIEndpoint {
  static var scopeRequired = "moderator:manage:automod";
  static var oauthRequired = true;
  static var method = HttpMethod.Post;
  static var endpoint = "moderation/automod/message";

  public static function call(client:Client, request:ManageHeldAutoModMessagesRequest):APIResponse<ManageHeldAutoModMessagesResponse> {
    return APIEndpoint.call(method, endpoint, client, [], request);
  }
}