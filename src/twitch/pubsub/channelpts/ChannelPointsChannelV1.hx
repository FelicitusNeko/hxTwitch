package twitch.pubsub.channelpts;

import haxe.Template;
import twitch.Client;
import twitch.api.URLScaleCollection;
import twitch.pubsub.PubSubTopic;

typedef ChannelPointsChannelV1Message = {
	var type:String;
	var data:{
		var timestamp:String;
		var redemption:{
			var user:{
				var id:String;
				var login:String;
				var display_name:String;
			};
			var channel_id:String;
			var redeemed_at:String;
			var reward:{
				var id:String;
				var channel_id:String;
				var title:String;
				var prompt:String;
				var cost:Int;
				var is_user_input_required:Bool;
				var is_sub_only:Bool;
				var image:URLScaleCollection;
				var default_image:URLScaleCollection;
				var background_color:String;
				var is_enabled:Bool;
				var is_paused:Bool;
				var is_in_stock:Bool;
				var max_per_stream:{
					var is_enabled:Bool;
					var max_per_stream:Int;
				};
			};
			var ?user_input:String;
			var status:String;
		}
	};
}

/** A custom reward is redeemed in a channel. **/
class ChannelPointsChannelV1 extends PubSubTopic {
	public static var scope = "channel:read:redemptions";
	public static var topicTemplate = "channel-points-channel-v1.::channelId::";

	public static function listen(client:Client, callback:ChannelPointsChannelV1Message->Void, channelId:String) {
		PubSubTopic.listen(client, new Template(topicTemplate).execute({channelId: channelId}), callback);
	}

	public static function unlisten(client:Client, channelId:String) {
		client.psUnlisten(new Template(topicTemplate).execute({channelId: channelId}));
	}
}
