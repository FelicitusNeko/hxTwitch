package twitch.api.eventSub;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef DeleteEventSubSubscriptionQuery = {
  var id:String;
}

typedef DeleteEventSubSubscriptionRequest = {
}

typedef DeleteEventSubSubscriptionResponse = {}

class DeleteEventSubSubscription extends APIEndpoint {
  static var scopeRequired = "";
  static var oauthRequired = true;
  static var method = HttpMethod.Delete;
  static var endpoint = "eventsub/subscriptions";

  public static function call(client:Client, query:DeleteEventSubSubscriptionQuery):APIResponse<DeleteEventSubSubscriptionResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}