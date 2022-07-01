package twitch.pubsub.channelsubs;

import haxe.Template;
import twitch.Client;
import twitch.pubsub.PubSubTopic;

typedef ChannelSubscribeEventsV1Message = {
  var channel_id:String;
  var channel_name:String;
  var ?user_id:String;
  var ?user_name:String;
  var ?display_name:String;
  var ?recipient_id:String;
  var ?recipient_user_name:String;
  var ?recipient_display_name:String;
  var ?multi_month_duration:Int;
  var time:String;
  var sub_plan:String;
  var sub_plan_name:String;
  var ?months:Int;
  var ?cumulative_months:Int;
  var ?streak_months:Int;
  var context:String;
  var is_gift:Bool;
  var sub_message:{
    var message:String;
    var ?emotes:Array<{
      var start:Int;
      var end:Int;
      var id:Int;
    }>;
  }
}

class ChannelSubscribeEventsV1 extends PubSubTopic {
  public static var scope = "channel:read:subscriptions";
  public static var topicTemplate = "channel-subscribe-events-v1.::channelId::";

  public static function listen(client:Client, callback:ChannelSubscribeEventsV1Message->Void, channelId:String) {
    PubSubTopic.listen(client, new Template(topicTemplate).execute({channelId: channelId}), callback);
  }

  public static function unlisten(client:Client, channelId:String) {
    client.psUnlisten(new Template(topicTemplate).execute({channelId: channelId}));
  }
}