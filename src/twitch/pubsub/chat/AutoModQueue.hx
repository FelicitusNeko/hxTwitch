package twitch.pubsub.chat;

import haxe.Template;
import twitch.Client;
import twitch.pubsub.PubSubTopic;

typedef AutoModQueueMessage = {
  var type:String;
  var data:{
    var message: {
      var id:String;
      var content: {
        var text:String;
        var fragments:Array<{
          var text:String;
          var automod:Dynamic; // TODO: find out the exact type needed for this
        }>;
      };
      var sender:{
        var user_id:String;
        var login:String;
        var display_name:String;
        var chat_color:String;
      };
      var sent_at:String;
      var content_classification:{
        var category:String;
        var level:Int;
      }
      var status:String;
      var reason_code:String;
      var resolver_id:String;
      var resolver_login:String;
    };
  };
}

/** A user’s message held by AutoMod has been approved or denied. **/
class AutoModQueue extends PubSubTopic {
  public static var scope = "chat:moderate";
  public static var topicTemplate = "automod-queue.::moderatorId::.::channelId::";

  public static function listen(client:Client, callback:AutoModQueueMessage->Void, moderatorId:String, channelId:String) {
    PubSubTopic.listen(client, new Template(topicTemplate).execute({moderatorId: moderatorId, channelId: channelId}), callback);
  }

  public static function unlisten(client:Client, moderatorId:String, channelId:String) {
    client.psUnlisten(new Template(topicTemplate).execute({moderatorId: moderatorId, channelId: channelId}));
  }
}