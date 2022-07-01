package twitch.pubsub.bits;

import haxe.Template;
import twitch.Client;
import twitch.pubsub.PubSubTopic;

typedef ChannelBitsEventsV1Message = {
  var data:{
    var ?badge_entitlement:{
      var new_version:Int;
      var previous_version:Int;
    }
    var bits_used:Int;
    var channel_id:String;
    var channel_name:String;
    var chat_message:String;
    var context:String;
    var time:String;
    var user_id:String;
    var user_name:String;
  };
  var message_id:String;
  var message_type:String;
  var version:String;
}

/** Anyone cheers in a specified channel. **/
class ChannelBitsEventsV1 extends PubSubTopic {
  public static var scope = "bits:read";
  public static var topicTemplate = "channel-bits-events-v1.::channelId::";

  public static function listen(client:Client, callback:ChannelBitsEventsV1Message->Void, channelId:String) {
    PubSubTopic.listen(client, new Template(topicTemplate).execute({channelId: channelId}), callback);
  }

  public static function unlisten(client:Client, channelId:String) {
    client.psUnlisten(new Template(topicTemplate).execute({channelId: channelId}));
  }
}