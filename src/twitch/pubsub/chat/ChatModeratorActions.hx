package twitch.pubsub.chat;

import haxe.Template;
import twitch.Client;
import twitch.pubsub.PubSubTopic;

// TODO: The structure for this message type is completely missing from the official documentation.
typedef ChatModeratorActionsMessage = Dynamic;

/**
  Supports moderators listening to the topic, as well as users listening to the topic to receive their own events. 

  Examples of moderator actions are bans, unbans, timeouts, deleting messages,
  changing chat mode (followers-only, subs-only), changing AutoMod levels, and adding a mod.
**/
class ChatModeratorActions extends PubSubTopic {
	public static var scope = "channel:moderate";
	public static var topicTemplate = "chat_moderator_actions.::userId::.::channelId::";

	public static function listen(client:Client, callback:ChatModeratorActionsMessage->Void, userId:String, channelId:String) {
		PubSubTopic.listen(client, new Template(topicTemplate).execute({userId: userId, channelId: channelId}), callback);
	}

	public static function unlisten(client:Client, userId:String, channelId:String) {
		client.psUnlisten(new Template(topicTemplate).execute({userId: userId, channelId: channelId}));
	}
}
