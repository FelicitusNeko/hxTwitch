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
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Delete;
  public static varendpoint = "eventsub/subscriptions";

  public static function call(client:Client, query:DeleteEventSubSubscriptionQuery):APIResponse<DeleteEventSubSubscriptionResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}