package twitch.api.channelPoints;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetCustomRewardRedemptionQuery = {
  var broadcaster_id:String;
  var reward_id:String;
  var ?id:String;
  var ?status:String;
  var ?sort:String;
  var ?after:String;
  var ?first:Int;
}

typedef GetCustomRewardRedemptionRequest = {
}

typedef GetCustomRewardRedemptionResponse = Array<{
  var broadcaster_id:String;
  var broadcaster_login:String;
  var broadcaster_name:String;
  var id:String;
  var user_id:String;
  var user_login:String;
  var user_name:String;
  var status:String;
  var redeemed_at:String;
  var reward:{
    var id:String;
    var title:String;
    var prompt:String;
    var cost:Int;
  };
}>

class GetCustomRewardRedemption extends APIEndpoint {
  public static var scopeRequired = "channel:read:redemptions";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "custom_rewards/redemptions";

  public static function call(client:Client, query:GetCustomRewardRedemptionQuery):APIResponse<GetCustomRewardRedemptionResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}