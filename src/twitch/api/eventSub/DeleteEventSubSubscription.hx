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
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Delete;
  public static var endpoint = "eventsub/subscriptions";

  public static function call(client:Client, query:DeleteEventSubSubscriptionQuery):APIResponse<DeleteEventSubSubscriptionResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}