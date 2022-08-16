package twitch.chat;

/** The data pertaining to this incoming chat message. **/
typedef ParsedChatMessage = {
	/** The raw text content of the message. **/
	var rawMessage:String;

	/** The origin of the message. **/
	var ?origin:String;

	/** The originating user of the message. Will generally be `null` if the message originates from the server. **/
	var ?user:String;

	/** The destination of the message. **/
	var ?destination:String;

	/** The message parameters. **/
	var ?params:String;
}

/** The data pertaining to this incoming chat message, which includes tags. **/
@:generic
typedef ParsedChatMessageWith<T> = {
	/** The raw text content of the message. **/
	var rawMessage:String;

	/** The tags attached to this message. **/
	var ?tags:T;

	/** The origin of the message. **/
	var ?origin:String;

	/** The originating user of the message. Will generally be `null` if the message originates from the server. **/
	var ?user:String;

	/** The destination of the message. **/
	var ?destination:String;

	/** The message parameters. **/
	var ?params:String;
}

/**
	The Twitch IRC server sends this message after a bot or moderator removes all messages from the chat room or removes all messages for the specified user.
	[Learn more](https://dev.twitch.tv/docs/irc/commands#clearchat)
**/
typedef ClearChatTags = {
	/** Optional. The message includes this tag if the user was put in a timeout. The tag contains the duration of the timeout, in seconds. **/
	var ?ban_duration:Int;

	/** The ID of the channel where the messages were removed from. **/
	var ?room_id:String;

	/** Optional. The ID of the user that was banned or put in a timeout. The user was banned if the message doesn’t include the `ban_duration` tag. **/
	var ?target_user_id:String;

	/** A `Date` representation of the UNIX timestamp. **/
	var ?tmi_sent_ts:Date;
}

/**
	The Twitch IRC server sends this message after the bot removes a single message from the chat room.
	[Learn more](https://dev.twitch.tv/docs/irc/commands#clearmsg)
**/
typedef ClearMsgTags = {
	/** The name of the user who sent the message. **/
	var ?login:String;

	/** Optional. The ID of the channel (chat room) where the message was removed from. **/
	var ?room_id:String;

	/** A UUID that identifies the message that was removed. **/
	var ?target_msg_id:String;

	/** A `Date` representation of the UNIX timestamp. **/
	var ?tmi_sent_ts:Date;
}

/**
	The Twitch IRC server sends this message after the bot authenticates with the server.
	[Learn more](https://dev.twitch.tv/docs/irc/commands#globaluserstate)
**/
typedef GlobalUserStateTags = {
	/**
		Contains metadata related to the chat badges in the `badges` tag.

		Currently, this tag contains metadata only for subscriber badges, to indicate the number of months the user has been a subscriber.
	**/
	var ?badge_info:Array<{
		var type:String;
		var months:Int;
	}>;

	/**
		Comma-separated list of chat badges in the form, `<badge>/<version>`. For example, `admin/1`. There are many possible badge values, but here are few:
		- admin
		- bits
		- broadcaster
		- moderator
		- subscriber
		- staff
		- turbo

		Most badges have only 1 version, but some badges like subscriber badges offer different versions of the badge depending on how long the user has subscribed.

		To get the badge, use the `GetGlobalChatBadges` and `GetChannelChatBadges` APIs. Match the badge to the `set-id` field’s value in the response.
		Then, match the version to the `id` field in the list of versions.
	**/
	var ?badges:Array<{
		var type:String;
		var version:Int;
	}>;

	/** The color of the user’s name in the chat room. This is a hexadecimal RGB color code in the form, #<RGB>. This tag may be empty if it is never set. **/
	var ?color:String;

	/** The user’s display name, escaped as described in the [IRCv3 spec](https://ircv3.net/specs/core/message-tags-3.2.html). This tag may be empty if it is never set. **/
	var ?display_name:String;

	/**
		An array of IDs that identify the emote sets that the user has access to. Is always set to at least zero (0).
		To access the emotes in the set, use the `GetEmoteSets` API.
	**/
	var ?emote_sets:Array<String>;

	/** A Boolean value that indicates whether the user has site-wide commercial free mode enabled. **/
	var ?turbo:Bool;

	/** The user's ID. **/
	var ?user_id:String;

	/**
		The type of user. Possible values are:

		- `""` — A normal user
		- `admin` — A Twitch administrator
		- `global_mod` — A global moderator
		- `staff` — A Twitch employee
	**/
	var ?user_type:String;
}

/** The Twitch IRC server sends this message to indicate the outcome of the action. **/
typedef NoticeTags = {
	/**
		An ID that you can use to programmatically determine the action’s outcome.
		For a list of possible IDs, see [NOTICE Message IDs](https://dev.twitch.tv/docs/irc/msg-id).
	**/
	var ?msg_id:String;

	/** The ID of the user that the action targeted. **/
	var ?target_user_id:String;
}

/** The Twitch IRC server sends this message after a user posts a message to the chat room. **/
typedef PrivMsgTags = {
	/**
		Contains metadata related to the chat badges in the `badges` tag.

		Currently, this tag contains metadata only for subscriber badges, to indicate the number of months the user has been a subscriber.
	**/
	var ?badge_info:Array<{
		/** The type of badge referenced. Currently can only be `subscriber`. **/
		var type:String;

		/** The number of total months the user has been subscribed. **/
		var months:Int;
	}>;

	/**
		Comma-separated list of chat badges in the form, `<badge>/<version>`. For example, `admin/1`. There are many possible badge values, but here are few:
		- admin
		- bits
		- broadcaster
		- moderator
		- subscriber
		- staff
		- turbo

		Most badges have only 1 version, but some badges like subscriber badges offer different versions of the badge depending on how long the user has subscribed.

		To get the badge, use the `GetGlobalChatBadges` and `GetChannelChatBadges` APIs. Match the badge to the `set-id` field’s value in the response.
		Then, match the version to the `id` field in the list of versions.
	**/
	var ?badges:Array<{
		/** The type of badge. **/
		var type:String;

		/** The version of the badge used. **/
		var version:Int;
	}>;

	/**
		The amount of Bits the user cheered. Only a Bits cheer message includes this tag.
		To learn more about Bits, see the [Extensions Monetization Guide](https://help.twitch.tv/s/article/guide-to-cheering-with-bits).
		To get the cheermote, use the `GetCheermotes` API. Match the cheer amount to the `id` field’s value in the response.
		Then, get the cheermote’s URL based on the cheermote theme, type, and size you want to use.
	**/
	var ?bits:Int;

	/** The color of the user’s name in the chat room. This is a hexadecimal RGB color code in the form, #<RGB>. This tag may be empty if it is never set. **/
	var ?color:String;

	/** A string that indicates which custom reward, if any, is associated to this message. **/
	var ?custom_reward_id:String;

	/** The user’s display name, escaped as described in the [IRCv3 spec](https://ircv3.net/specs/core/message-tags-3.2.html). This tag may be empty if it is never set. **/
	var ?display_name:String;

	/**
		An array of emotes and their positions in the message. The position indices are zero-based.

		To get the actual emote, see the `GetChannelEmotes` and `GetGlobalEmotes` APIs.
		For information about how to use the information that the APIs return, see [Twitch emotes](https://dev.twitch.tv/docs/irc/emotes).

		**NOTE** It’s possible for the `emotes` flag’s value to be set to an action instead of identifying an emote. For example, `\001ACTION barfs on the floor.\001`.
	**/
	var ?emotes:Array<{
		/** The ID of the emote. **/
		var id:String;

		/** The start position for this emote, inclusive. **/
		var from:Int;

		/** The end position for this emote, inclusive. **/
		var to:Int;
	}>;

	/** A Boolean value that indicates whether this is the user's first message in the channel. **/
	var ?first_msg:Bool;

	/**	An ID that uniquely identifies the message. **/
	var ?id:String;

	/** A Boolean value that determines whether the user is a moderator. **/
	var ?mod:Bool;

	/** A string that indicates what type of message this is. Used for `highlighted_message`. **/
	var ?msg_id:String;

	/** A Boolean value that determines whether the user has returned after a long absence. (This is speculation; no official documentation for this tag.) **/
	var ?returning_chatter:Bool;

	/** If this message is a reply to someone, the data that pertains to the message being replied to. **/
	var ?reply_parent:{
		/** An ID that uniquely identifies the parent message that this message is replying to. **/
		var ?msg_id:String;

		/** An ID that identifies the sender of the parent message. **/
		var ?user_id:String;

		/** The login name of the sender of the parent message. **/
		var ?user_login:String;

		/** The display name of the sender of the parent message. **/
		var ?display_name:String;

		/** The text of the parent message. **/
		var ?msg_body:String;
	}

	/** An ID that identifies the chat room (channel). **/
	var ?room_id:String;

	/** A Boolean value that determines whether the user is a subscriber. **/
	var ?subscriber:Bool;

	/** A `Date` representation of the UNIX timestamp. **/
	var ?tmi_sent_ts:Date;

	/** A Boolean value that indicates whether the user has site-wide commercial free mode enabled. **/
	var ?turbo:Bool;

	/** The user's ID. **/
	var ?user_id:String;

	/**
		The type of user. Possible values are:

		- `""` — A normal user
		- `admin` — A Twitch administrator
		- `global_mod` — A global moderator
		- `staff` — A Twitch employee
	**/
	var ?user_type:String;
}

/**
	The Twitch IRC server sends this message after a bot joins a channel or when the channel’s chat room settings change.
	[Learn more](https://dev.twitch.tv/docs/irc/commands#roomstate)

	For JOIN messages, the message contains all chat room setting tags, but for actions that change a single chat room setting,
	the message includes only that chat room setting tag. For example, if the moderator turned on unique chat, the message includes only the r9k tag.
**/
typedef RoomStateTags = {
	/** A Boolean value that determines whether the chat room allows only messages with emotes. **/
	var ?emote_only:Bool;

	/**
		An integer value that determines whether only followers can post messages in the chat room.
		The value indicates how long, in minutes, the user must have followed the broadcaster before posting chat messages.
		If the value is -1, the chat room is not restricted to followers only.
	**/
	var ?followers_only:Int;

	/** A Boolean value that determines whether a user’s messages must be unique. Applies only to messages with more than 9 characters. **/
	var ?r9k:Bool;

	/** An ID that identifies the chat room (channel). **/
	var ?room_id:String;

	/** An integer value that determines how long, in seconds, users must wait between sending messages. **/
	var ?slow:Int;

	/** A Boolean value that determines whether only subscribers and moderators can chat in the chat room. **/
	var ?subs_only:Bool;
}

/**
	  The Twitch IRC server sends this message after the following events occur:

	  - A user subscribes to the channel, re-subscribes to the channel, or gifts a subscription to another user.
	  - A broadcaster raids the channel. Raid is a Twitch feature that lets broadcasters send their viewers to another channel
	to help support and grow other members in the community.
	  - A viewer milestone is celebrated such as a new viewer chatting for the first time. These celebrations are called rituals.

	  [Learn more](https://dev.twitch.tv/docs/irc/commands#usernotice)
**/
@:generic
typedef UserNoticeTags<T> = {
	/**
		Contains metadata related to the chat badges in the `badges` tag.

		Currently, this tag contains metadata only for subscriber badges, to indicate the number of months the user has been a subscriber.
	**/
	var ?badge_info:Array<{
		var type:String;
		var months:Int;
	}>;

	/**
		Comma-separated list of chat badges in the form, `<badge>/<version>`. For example, `admin/1`. There are many possible badge values, but here are few:
		- admin
		- bits
		- broadcaster
		- moderator
		- subscriber
		- staff
		- turbo

		Most badges have only 1 version, but some badges like subscriber badges offer different versions of the badge depending on how long the user has subscribed.

		To get the badge, use the `GetGlobalChatBadges` and `GetChannelChatBadges` APIs. Match the badge to the `set-id` field’s value in the response.
		Then, match the version to the `id` field in the list of versions.
	**/
	var ?badges:Array<{
		var type:String;
		var version:Int;
	}>;

	/** The color of the user’s name in the chat room. This is a hexadecimal RGB color code in the form, #<RGB>. This tag may be empty if it is never set. **/
	var ?color:String;

	/** The user’s display name, escaped as described in the [IRCv3 spec](https://ircv3.net/specs/core/message-tags-3.2.html). This tag may be empty if it is never set. **/
	var ?display_name:String;

	/**
		An array of emotes and their positions in the message. The position indices are zero-based.

		To get the actual emote, see the `GetChannelEmotes` and `GetGlobalEmotes` APIs.
		For information about how to use the information that the APIs return, see [Twitch emotes](https://dev.twitch.tv/docs/irc/emotes).

		**NOTE** It’s possible for the `emotes` flag’s value to be set to an action instead of identifying an emote. For example, `\001ACTION barfs on the floor.\001`.
	**/
	var ?emotes:Array<{
		/** The ID of the emote. **/
		var id:String;

		/** The start position for this emote, inclusive. **/
		var from:Int;

		/** The end position for this emote, inclusive. **/
		var to:Int;
	}>;

	/**	An ID that uniquely identifies the message. **/
	var ?id:String;

	/** The login name of the user whose action generated the message. **/
	var ?login:String;

	/** A Boolean value that determines whether the user is a moderator. **/
	var ?mod:Bool;

	/**
		The *type* of notice (*not* the ID). Possible values are:

		- sub
		- resub
		- subgift
		- giftpaidupgrade
		- rewardgift
		- anongiftpaidupgrade
		- raid
		- unraid
		- ritual
		- bitsbadgetier
	**/
	var ?msg_id:String;

	/** Data pertaining to the specific type of `msg_id` invoked. **/
	var ?msg_param:T;

	/** An ID that identifies the chat room (channel). **/
	var ?room_id:String;

	/** A Boolean value that determines whether the user is a subscriber. **/
	var ?subscriber:Bool;

	/** The message Twitch shows in the chat room for this notice. **/
	var ?system_msg:String;

	/** A `Date` representation of the UNIX timestamp. **/
	var ?tmi_sent_ts:Date;

	/** A Boolean value that indicates whether the user has site-wide commercial free mode enabled. **/
	var ?turbo:Bool;

	/** The user's ID. **/
	var ?user_id:String;

	/**
		The type of user. Possible values are:

		- `""` — A normal user
		- `admin` — A Twitch administrator
		- `global_mod` — A global moderator
		- `staff` — A Twitch employee
	**/
	var ?user_type:String;
}

/** `msg_param` data for `bitsbadgetier` message types. **/
typedef ForBitsBadgeTier = {
	/** The tier of the Bits badge the user just earned. For example, 100, 1000, or 10000. **/
	var ?threshold:Int;
}

/** `msg_param` data for `giftpaidupgrade` and `anongiftpaidupgrade` message types. **/
typedef ForGiftPaidUpgrade = {
	/** The number of gifts the gifter has given during the promo indicated by `msg-param-promo-name`. **/
	var ?promo_gift_total:Int;

	/** The subscriptions promo, if any, that is ongoing (for example, Subtember 2018). **/
	var ?promo_name:String;

	/** The login name of the user who gifted the subscription. Not present if the gift is anonymous. **/
	var ?sender_login:String;

	/** The display name of the user who gifted the subscription. Not present if the gift is anonymous. **/
	var ?sender_name:String;
}

/** `msg_param` data for `raid` message types. **/
typedef ForRaid = {
	/** The display name of the broadcaster raiding this channel. **/
	var ?displayName:String;

	/** The login name of the broadcaster raiding this channel. **/
	var ?login:String;

	/** The number of viewers raiding this channel from the broadcaster’s channel. **/
	var ?viewerCount:Int;
}

/** `msg_param` data for `ritual` message types. **/
typedef ForRitual = {
	/** The name of the ritual being celebrated. Possible values are: `new_chatter`. **/
	var ?ritual_name:String;
}

/** `msg_param` data for `sub` and `resub` USERNOTICE types. **/
typedef ForSub = {
	/** The total number of months the user has subscribed. **/
	var ?cumulative_months:Int;

	/** A Boolean value that indicates whether the user wants their streaks shared. **/
	var ?should_share_streak:Bool;

	/** The number of consecutive months the user has subscribed. This is zero (`0`) if `msg-param-should-share-streak` is `false`. **/
	var ?streak_months:Int;

	/**
		The type of subscription plan being used. Possible values are:

		- Prime — Amazon Prime subscription
		- 1000 — First level of paid subscription
		- 2000 — Second level of paid subscription
		- 3000 — Third level of paid subscription
	**/
	var ?sub_plan:String;

	/** The display name of the subscription plan. This may be a default name or one created by the channel owner. **/
	var ?sub_plan_name:String;
}

/** `msg_param` data for `subgift` message types. **/
typedef ForSubGift = {
	/** The total number of months the user has subscribed. **/
	var ?months:Int;

	/** Data pertaining to the recipient of the gift sub. **/
	var ?recipient:{
		/** The display name of the subscription gift recipient. **/
		var ?display_name:String;

		/** The user ID of the subscription gift recipient. **/
		var ?id:String;

		/** The user name of the subscription gift recipient. **/
		var ?user_name:String;
	}

	/**
		The type of subscription plan being used. Possible values are:

		- Prime — Amazon Prime subscription
		- 1000 — First level of paid subscription
		- 2000 — Second level of paid subscription
		- 3000 — Third level of paid subscription
	**/
	var ?sub_plan:String;

	/** The display name of the subscription plan. This may be a default name or one created by the channel owner. **/
	var ?sub_plan_name:String;

	/** The number of months gifted as part of a single, multi-month gift. **/
	var ?gift_months:Int;
}

/** Reserved for `USERNOTICE` message types that do not have any additional `msg_param` information. **/
typedef ForOther = Dynamic;

/**
	The Twitch IRC server sends this message after the bot joins a channel or sends a `PRIVMSG` message.
	[Learn more](https://dev.twitch.tv/docs/irc/commands#userstate)
**/
typedef UserStateTags = {
	/**
		Contains metadata related to the chat badges in the `badges` tag.

		Currently, this tag contains metadata only for subscriber badges, to indicate the number of months the user has been a subscriber.
	**/
	var ?badge_info:Array<{
		var type:String;
		var months:Int;
	}>;

	/**
		Comma-separated list of chat badges in the form, `<badge>/<version>`. For example, `admin/1`. There are many possible badge values, but here are few:
		- admin
		- bits
		- broadcaster
		- moderator
		- subscriber
		- staff
		- turbo

		Most badges have only 1 version, but some badges like subscriber badges offer different versions of the badge depending on how long the user has subscribed.

		To get the badge, use the `GetGlobalChatBadges` and `GetChannelChatBadges` APIs. Match the badge to the `set-id` field’s value in the response.
		Then, match the version to the `id` field in the list of versions.
	**/
	var ?badges:Array<{
		var type:String;
		var version:Int;
	}>;

	/** The color of the user’s name in the chat room. This is a hexadecimal RGB color code in the form, #<RGB>. This tag may be empty if it is never set. **/
	var ?color:String;

	/** The user’s display name, escaped as described in the [IRCv3 spec](https://ircv3.net/specs/core/message-tags-3.2.html). This tag may be empty if it is never set. **/
	var ?display_name:String;

	/**
		An array of IDs that identify the emote sets that the user has access to. Is always set to at least zero (0).
		To access the emotes in the set, use the `GetEmoteSets` API.
	**/
	var ?emote_sets:Array<String>;

	/** A Boolean value that determines whether the user is a moderator. **/
	var ?mod:Bool;

	/** A Boolean value that determines whether the user is a subscriber. **/
	var ?subscriber:Bool;

	/** A Boolean value that indicates whether the user has site-wide commercial free mode enabled. **/
	var ?turbo:Bool;

	/**
		The type of user. Possible values are:

		- `""` — A normal user
		- `admin` — A Twitch administrator
		- `global_mod` — A global moderator
		- `staff` — A Twitch employee
	**/
	var ?user_type:String;
}

/**
	The Twitch IRC server sends this message after someone sends your client a whisper message.
	[Learn more](https://dev.twitch.tv/docs/irc/commands#whisper)
**/
typedef WhisperTags = {
	/**
		Comma-separated list of chat badges in the form, `<badge>/<version>`. For example, `admin/1`. There are many possible badge values, but here are few:
		- admin
		- bits
		- broadcaster
		- moderator
		- subscriber
		- staff
		- turbo

		Most badges have only 1 version, but some badges like subscriber badges offer different versions of the badge depending on how long the user has subscribed.

		To get the badge, use the `GetGlobalChatBadges` and `GetChannelChatBadges` APIs. Match the badge to the `set-id` field’s value in the response.
		Then, match the version to the `id` field in the list of versions.
	**/
	var ?badges:Array<{
		/** The type of badge. **/
		var type:String;

		/** The version of the badge used. **/
		var version:Int;
	}>;

	/** The color of the user’s name in the chat room. This is a hexadecimal RGB color code in the form, #<RGB>. This tag may be empty if it is never set. **/
	var ?color:String;

	/** The user’s display name, escaped as described in the [IRCv3 spec](https://ircv3.net/specs/core/message-tags-3.2.html). This tag may be empty if it is never set. **/
	var ?display_name:String;

	/**
		An array of emotes and their positions in the message. The position indices are zero-based.

		To get the actual emote, see the `GetChannelEmotes` and `GetGlobalEmotes` APIs.
		For information about how to use the information that the APIs return, see [Twitch emotes](https://dev.twitch.tv/docs/irc/emotes).

		**NOTE** It’s possible for the `emotes` flag’s value to be set to an action instead of identifying an emote. For example, `\001ACTION barfs on the floor.\001`.
	**/
	var ?emotes:Array<{
		/** The ID of the emote. **/
		var id:String;

		/** The start position for this emote, inclusive. **/
		var from:Int;

		/** The end position for this emote, inclusive. **/
		var to:Int;
	}>;

	/**	An ID that uniquely identifies the whisper message. **/
	var ?message_id:String;

	/** An ID that uniquely identifies the whisper thread. The ID is in the form, `<smaller-value-user-id>_<larger-value-user-id>`. **/
	var ?thread_id:String;

	/** A Boolean value that indicates whether the user has site-wide commercial free mode enabled. **/
	var ?turbo:Bool;

	/** The ID of the user sending the whisper message. **/
	var ?user_id:String;

	/**
		The type of user sending the whisper message. Possible values are:

		- `""` — A normal user
		- `admin` — A Twitch administrator
		- `global_mod` — A global moderator
		- `staff` — A Twitch employee
	**/
	var ?user_type:String;
}

/** The type of chat message the client has received and parsed. **/
enum ChatMessageType {
	/**
		Your client receives this message from the Twitch IRC server when a user joins a channel your client is in.
	**/
	Join(msg:ParsedChatMessage);

	/**
			Your client receives this message from the Twitch IRC server when it fails to authenticate with the server.

		Your client also receives this message from the Twitch IRC server to indicate whether a command succeeded or failed.
		For example, a moderator tried to ban a user that was already banned.
			[Read more](https://dev.twitch.tv/docs/irc/commands#notice).
	**/
	Notice(msg:ParsedChatMessageWith<NoticeTags>);

	/**
		Your client receives this message from the Twitch IRC server when a user leaves a channel your client is in.

		Your client also receives this message from the Twitch IRC server when a channel bans it.
	**/
	Part(msg:ParsedChatMessage);

	/**
		Your client receives this message from the Twitch IRC server when the server wants to ensure that your client is still alive
		and able to respond to the server’s messages. See [Keepalive messages](https://dev.twitch.tv/docs/irc#keepalive-messages).
	**/
	Ping(msg:ParsedChatMessage);

	/**
		Your client receives this message from the Twitch IRC server when a user posts a chat message in the chat room.
		See [Sending and receiving chat messages](https://dev.twitch.tv/docs/irc/send-receive-messages).
	**/
	PrivMsg(msg:ParsedChatMessageWith<PrivMsgTags>);

	/**
		Your client receives this message from the Twitch IRC server when all messages are removed from the chat room,
		or all messages for a specific user are removed from the chat room. [Read more](https://dev.twitch.tv/docs/irc/commands#clearchat).
	**/
	ClearChat(msg:ParsedChatMessageWith<ClearChatTags>);

	/**
		Your client receives this message from the Twitch IRC server when a specific message is removed from the chat room.
		[Read more](https://dev.twitch.tv/docs/irc/commands#clearmsg).
	**/
	ClearMsg(msg:ParsedChatMessageWith<ClearMsgTags>);

	/**
		Your client receives this message from the Twitch IRC server when a bot connects to the server.
			[Read more](https://dev.twitch.tv/docs/irc/commands#globaluserstate).
	**/
	GlobalUserState(msg:ParsedChatMessageWith<GlobalUserStateTags>);

	/**
		Your client receives this message from the Twitch IRC server when a channel starts or stops host mode.
			[Read more](https://dev.twitch.tv/docs/irc/commands#hosttarget).
	**/
	HostTarget(msg:ParsedChatMessage);

	/**
		Your client receives this message from the Twitch IRC server when the server needs to perform maintenance and is about to disconnect your client.
			[Read more](https://dev.twitch.tv/docs/irc/commands#reconnect).
	**/
	Reconnect(msg:ParsedChatMessage);

	/**
		Your client receives this message from the Twitch IRC server when a bot joins a channel or a moderator changes the chat room’s chat settings.
			[Read more](https://dev.twitch.tv/docs/irc/commands#roomstate).
	**/
	RoomState(msg:ParsedChatMessageWith<RoomStateTags>);

	/**
		Your bot receives this message from the Twitch IRC server when events like user subscriptions occur.
		This type is specific to `bitsbadgetier` messages.
		[Read more](https://dev.twitch.tv/docs/irc/commands#usernotice).
	**/
	BitsTierUserNotice(msg:ParsedChatMessageWith<UserNoticeTags<ForBitsBadgeTier>>);

	/**
		Your bot receives this message from the Twitch IRC server when events like user subscriptions occur.
		This type is specific to `giftpaidupgrade` and `anongiftpaidupgrade` messages.
		[Read more](https://dev.twitch.tv/docs/irc/commands#usernotice).
	**/
	GiftUpgradeUserNotice(msg:ParsedChatMessageWith<UserNoticeTags<ForGiftPaidUpgrade>>);

	/**
		Your bot receives this message from the Twitch IRC server when events like user subscriptions occur.
		This type is specific to `raid` messages.
		[Read more](https://dev.twitch.tv/docs/irc/commands#usernotice).
	**/
	RaidUserNotice(msg:ParsedChatMessageWith<UserNoticeTags<ForRaid>>);

	/**
		Your bot receives this message from the Twitch IRC server when events like user subscriptions occur.
		This type is specific to `ritual` messages.
		[Read more](https://dev.twitch.tv/docs/irc/commands#usernotice).
	**/
	RitualUserNotice(msg:ParsedChatMessageWith<UserNoticeTags<ForRitual>>);

	/**
		Your bot receives this message from the Twitch IRC server when events like user subscriptions occur.
		This type is specific to `sub` and `resub` messages.
		[Read more](https://dev.twitch.tv/docs/irc/commands#usernotice).
	**/
	SubUserNotice(msg:ParsedChatMessageWith<UserNoticeTags<ForSub>>);

	/**
		Your bot receives this message from the Twitch IRC server when events like user subscriptions occur.
		This type is specific to `subgift` messages.
		[Read more](https://dev.twitch.tv/docs/irc/commands#usernotice).
	**/
	SubGiftUserNotice(msg:ParsedChatMessageWith<UserNoticeTags<ForSubGift>>);

	/**
		Your bot receives this message from the Twitch IRC server when events like user subscriptions occur.
		This type is specific to messages that do not contain specific additional data.
		[Read more](https://dev.twitch.tv/docs/irc/commands#usernotice).
	**/
	GenericUserNotice(msg:ParsedChatMessageWith<UserNoticeTags<ForOther>>);

	/**
		Your client receives this message from the Twitch IRC server when a user joins a channel or the bot sends a `PRIVMSG` message.
			[Read more](https://dev.twitch.tv/docs/irc/commands#userstate).
	**/
	UserState(msg:ParsedChatMessageWith<UserStateTags>);

	/**
		Your client receives this message from the Twitch IRC server when a user sends a `WHISPER` message.
			[Read more](https://dev.twitch.tv/docs/irc/commands#whisper).
	**/
	Whisper(msg:ParsedChatMessageWith<WhisperTags>);

	/**
		Your client may receive other types of messages (most typically "numeric" messages) as replies to unknown commands or
		standard boilerplate for connecting to the server or joining a channel.
	**/
	Other(type: String, msg:ParsedChatMessage);
}
