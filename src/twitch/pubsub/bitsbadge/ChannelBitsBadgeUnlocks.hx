package twitch.pubsub.bitsbadge;

import haxe.Template;
import twitch.Client;
import twitch.pubsub.PubSubTopic;

typedef ChannelBitsBadgeUnlocksMessage = {
  var badge_tier:Int;
  var channel_id:String;
  var channel_name:String;
  var chat_message:String;
  var time:String;
  var user_id:String;
  var user_name:String;
}

/** Message sent when a user earns a new Bits badge in a particular channel, and chooses to share the notification with chat. **/
class ChannelBitsBadgeUnlocks extends PubSubTopic {
  public static var scope = "bits:read";
  public static var topicTemplate = "channel-bits-badge-unlocks.::channelId::";

  public static function listen(client:Client, callback:ChannelBitsBadgeUnlocksMessage->Void, channelId:String) {
    PubSubTopic.listen(client, new Template(topicTemplate).execute({channelId: channelId}), callback);
  }

  public static function unlisten(client:Client, channelId:String) {
    client.psUnlisten(new Template(topicTemplate).execute({channelId: channelId}));
  }
}