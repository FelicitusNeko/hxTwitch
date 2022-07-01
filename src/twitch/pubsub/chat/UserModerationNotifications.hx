package twitch.pubsub.chat;

import haxe.Template;
import twitch.Client;
import twitch.pubsub.PubSubTopic;

typedef UserModerationNotificationsMessage = {
  var type:String;
  var data:{
    var message_id:String;
    var status:String;
  };
}

class UserModerationNotifications extends PubSubTopic {
	public static var scope = "chat:read";
	public static var topicTemplate = "user-moderation-notifications.::currentUserId::.::channelId::";

	public static function listen(client:Client, callback:UserModerationNotificationsMessage->Void, currentUserId:String, channelId:String) {
		PubSubTopic.listen(client, new Template(topicTemplate).execute({currentUserId: currentUserId, channelId: channelId}), callback);
	}

	public static function unlisten(client:Client, currentUserId:String, channelId:String) {
		client.psUnlisten(new Template(topicTemplate).execute({currentUserId: currentUserId, channelId: channelId}));
	}
}
