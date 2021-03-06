package twitch.chat;

import twitch.chat.ChatMessageType;

class ChatParser {
	static function parseClearChat(tags:Map<String, String>) {
		var retval:ClearChatTags = {};

		for (k => v in tags)
			switch (k) {
				case "ban-duration":
					retval.ban_duration = Std.parseInt(v);
				case "room-id":
					retval.room_id = v;
				case "target-user-id":
					retval.target_user_id = v;
				case "tmi-sent-ts":
					retval.tmi_sent_ts = Date.fromTime(Std.parseFloat(v.substr(0, v.length - 3) + "." + v.substr(v.length - 3)));
			}

		return retval;
	}

	static function parseClearMsg(tags:Map<String, String>) {
		var retval:ClearMsgTags = {};

		for (k => v in tags)
			switch (k) {
				case "login":
					retval.login = v;
				case "room-id":
					retval.room_id = v;
				case "target-msg-id":
					retval.target_msg_id = v;
				case "tmi-sent-ts":
					retval.tmi_sent_ts = Date.fromTime(Std.parseFloat(v.substr(0, v.length - 3) + "." + v.substr(v.length - 3)));
			}

		return retval;
	}

	static function parseGlobalUserState(tags:Map<String, String>) {
		var retval:GlobalUserStateTags = {};

		for (k => v in tags)
			switch (k) {
				case "badge-info":
					retval.badge_info = v.split(",").map(badge -> {
						var split = v.split("/");
						return {
							type: split[0],
							months: Std.parseInt(split[1])
						};
					});
				case "badges":
					retval.badges = v.split(",").map(badge -> {
						var split = v.split("/");
						return {
							type: split[0],
							version: Std.parseInt(split[1])
						};
					});
				case "color":
					retval.color = v;
				case "display-name":
					retval.display_name = v;
				case "emote-sets":
					retval.emote_sets = v.split(",");
				case "turbo":
					retval.turbo = v == "1";
				case "user-id":
					retval.user_id = v;
				case "user-type":
					retval.user_type = v;
			}

		return retval;
	}

	static function parseNotice(tags:Map<String, String>) {
		var retval:NoticeTags = {};

		for (k => v in tags)
			switch (k) {
				case "msg-id":
					retval.msg_id = v;
				case "target-user-id":
					retval.target_user_id = v;
			}

		return retval;
	}

	static function parsePrivmsg(tags:Map<String, String>) {
		var retval:PrivmsgTags = {};

		for (k => v in tags) {
			if (StringTools.startsWith(k, "reply") && retval.reply_parent == null)
				retval.reply_parent = {};
			switch (k) {
				case "badge-info":
					retval.badge_info = v.split(",").map(badge -> {
						var split = v.split("/");
						return {
							type: split[0],
							months: Std.parseInt(split[1])
						};
					});
				case "badges":
					retval.badges = v.split(",").map(badge -> {
						var split = v.split("/");
						return {
							type: split[0],
							version: Std.parseInt(split[1])
						};
					});
				case "bits":
					retval.bits = Std.parseInt(v);
				case "color":
					retval.color = v;
				case "display-name":
					retval.display_name = v;
				case "emotes":
					retval.emotes = v.split(",").map(emote -> {
						var emoteData = ~/(\n+):(\n+)-(\n+)/;
						if (emoteData.match(emote))
							return {
								id: emoteData.matched(1),
								from: Std.parseInt(emoteData.matched(2)),
								to: Std.parseInt(emoteData.matched(3))
							};
						else
							return {
								id: "",
								from: -1,
								to: -1
							};
					});
				case "first-msg":
					retval.first_msg = v == "1";
				case "id":
					retval.id = v;
				case "mod":
					retval.mod = v == "1";
				case "reply-parent-msg-id":
					retval.reply_parent.msg_id = v;
				case "reply-parent-user-id":
					retval.reply_parent.user_id = v;
				case "reply-parent-user-login":
					retval.reply_parent.user_login = v;
				case "reply-parent-display-name":
					retval.reply_parent.display_name = v;
				case "reply-parent-msg-body":
					retval.reply_parent.msg_body = v;
				case "returning-chatter":
					retval.returning_chatter = v == "1";
				case "room_id":
					retval.room_id = v;
				case "subscriber":
					retval.subscriber = v == "1";
				case "tmi-sent-ts":
					retval.tmi_sent_ts = Date.fromTime(Std.parseFloat(v.substr(0, v.length - 3) + "." + v.substr(v.length - 3)));
				case "turbo":
					retval.turbo = v == "1";
				case "user-id":
					retval.user_id = v;
				case "user-type":
					retval.user_type = v;
			}
		}
		return retval;
	}

	static function parseRoomState(tags:Map<String, String>) {
		var retval:RoomStateTags = {};

		for (k => v in tags)
			switch (k) {
				case "emote-only":
					retval.emote_only = v == "1";
				case "followers-only":
					retval.followers_only = Std.parseInt(v);
				case "r9k":
					retval.emote_only = v == "1";
				case "room-id":
					retval.room_id = v;
				case "slow":
					retval.slow = Std.parseInt(v);
				case "subs-only":
					retval.subs_only = v == "1";
			}

		return retval;
	}

	// TODO: UserNoticeTags

	static function parseUserState(tags:Map<String, String>) {
		var retval:UserStateTags = {};

		for (k => v in tags)
			switch (k) {
				case "badge-info":
					retval.badge_info = v.split(",").map(badge -> {
						var split = v.split("/");
						return {
							type: split[0],
							months: Std.parseInt(split[1])
						};
					});
				case "badges":
					retval.badges = v.split(",").map(badge -> {
						var split = v.split("/");
						return {
							type: split[0],
							version: Std.parseInt(split[1])
						};
					});
				case "color":
					retval.color = v;
				case "display-name":
					retval.display_name = v;
				case "emote-sets":
					retval.emote_sets = v.split(",");
				case "mod":
					retval.mod = v == "1";
				case "subscriber":
					retval.subscriber = v == "1";
				case "turbo":
					retval.turbo = v == "1";
				case "user-type":
					retval.user_type = v;
			}

		return retval;
	}

	static function parseWhisper(tags:Map<String, String>) {
		var retval:WhisperTags = {};

		for (k => v in tags)
			switch (k) {
				case "badges":
					retval.badges = v.split(",").map(badge -> {
						var split = v.split("/");
						return {
							type: split[0],
							version: Std.parseInt(split[1])
						};
					});
				case "color":
					retval.color = v;
				case "display-name":
					retval.display_name = v;
				case "emotes":
					retval.emotes = v.split(",").map(emote -> {
						var emoteData = ~/(\n+):(\n+)-(\n+)/;
						if (emoteData.match(emote))
							return {
								id: emoteData.matched(1),
								from: Std.parseInt(emoteData.matched(2)),
								to: Std.parseInt(emoteData.matched(3))
							};
						else
							return {
								id: "",
								from: -1,
								to: -1
							};
					});
				case "message-id":
					retval.message_id = v;
				case "thread-id":
					retval.thread_id = v;
				case "turbo":
					retval.turbo = v == "1";
				case "user-id":
					retval.user_id = v;
				case "user-type":
					retval.user_type = v;
			}

		return retval;
	}

	@:generic
	static function parseWithTags<T>(tokens:Array<String>, tagParser:Map<String, String>->T) {
		var retval:ParsedChatMessageWith<T> = {
			rawMessage: tokens.join(" ")
		};

		for (i => token in tokens) {
			var typeParsed = false;
			switch (token.charAt(0)) {
				case ":":
					if (typeParsed) {
						retval.params = tokens.slice(i).join(" ").substr(1);
						break;
					} else
						retval.origin = token.substr(1);
				case "@":
					var subtokens = token.substr(1).split("=");
					var tags:Map<String, String> = [];
					for (subtoken in subtokens) {
						var firstEqual = subtoken.indexOf("=");
						tags.set(subtoken.substr(0, firstEqual), subtoken.substr(firstEqual + 1));
					}
					retval.tags = tagParser(tags);
				default:
					typeParsed = true;
			}
		}

		return retval;
	}

	static function parseStandard(tokens:Array<String>) {
		var retval:ParsedChatMessage = {
			rawMessage: tokens.join(" ")
		};

		for (i => token in tokens) {
			var typeParsed = false;
			switch (token.charAt(0)) {
				case ":":
					if (typeParsed) {
						retval.params = tokens.slice(i).join(" ").substr(1);
						break;
					} else
						retval.origin = token.substr(1);
				case "@":
					trace("@ found in message data; may be parsing out tags as a result");
				default:
					typeParsed = true;
			}
		}

		return retval;
	}

	public static function parse(message:String) {
		var type:Null<String> = null;
		var tokens = message.split(" ");
		for (token in tokens)
			if (!["@", ":"].contains(token.charAt(0))) {
				type = token;
				break;
			}

		switch (type) {}
	}
}
