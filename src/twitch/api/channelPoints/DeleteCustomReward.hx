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
  static var scopeRequired = "channel:manage:redemptions";
  static var oauthRequired = true;
  static var method = HttpMethod.Delete;
  static var endpoint = "channel_points/custom_rewards";

  public static function call(client:Client, query:DeleteCustomRewardQuery):APIResponse<DeleteCustomRewardResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}