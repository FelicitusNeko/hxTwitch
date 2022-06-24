package twitch.api.channelPoints;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef DeleteCustomRewardQuery = {
  var broadcaster_id:String;
  var id:String;
}

typedef DeleteCustomRewardRequest = {}

typedef DeleteCustomRewardResponse = {}

class DeleteCustomReward extends APIEndpoint {
  public static varscopeRequired = "channel:manage:redemptions";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Delete;
  public static varendpoint = "channel_points/custom_rewards";

  public static function call(client:Client, query:DeleteCustomRewardQuery):APIResponse<DeleteCustomRewardResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}