package twitch.api;

import haxe.Exception;
import haxe.http.HttpMethod;
import haxe.Json;
import twitch.Client;

@:generic
typedef APIResponse<R> = {
	/** The HTTP return code supplied by the API endpoint. **/
	var ?code:Int;
	/** The data returned by the API endpoint, if any. **/
	var ?data:R;
	/** The date range for the returned data. **/
	var ?date_range:{
		/** Start of the date range for the returned data. **/
		var started_at:String;
		/** End of the date range for the returned data. **/
		var ended_at:String;
	};
	/** The total number of entries. **/
	var ?total:Int;
	/** The sum of all of your subscription costs. [Learn More](https://dev.twitch.tv/docs/eventsub/manage-subscriptions/#subscription-limits) **/
	var ?total_cost:Int;
	/** The maximum total cost that you may incur for all subscriptions you create. **/
	var ?max_total_cost:Int;
	/** A cursor value, to be used in a subsequent request to specify the starting point of the next set of results. **/
	var ?pagination:{
		/** The cursor used to page results. **/
		var cursor:String;
	};
	/**
		A templated URL. Use the values from `id`, `format`, `scale`, and `theme_mode` to replace the like-named placeholder strings
		in the templated URL to create a CDN (content delivery network) URL that you use to fetch the emote. For information about what
		the template looks like and how to use it to fetch emotes, see [Emote CDN URL format](https://dev.twitch.tv/docs/irc/emotes#cdn-template).
	**/
	var ?template:String;
	/**
		The current number of subscriber points earned by this broadcaster. Points are based on the subscription tier of each user that subscribes
		to this broadcaster. For example, a Tier 1 subscription is worth 1 point, Tier 2 is worth 2 points, and Tier 3 is worth 6 points. The
		number of points determines the number of emote slots that are unlocked for the broadcaster (see
		[Subscriber Emote Slots](https://help.twitch.tv/s/article/subscriber-emote-guide#emoteslots)).
	**/
	var ?points:Int;
}

class APIEndpoint {
	@:generic
	public static function call<R>(method:HttpMethod, endpoint:String, client:Client, ?query:Dynamic, ?data:Dynamic, authType = OAuthFirst):APIResponse<R> {
		if (query != null && !Reflect.isObject(query)) throw new Exception("Query data is not an object");

		var queryMap:Map<String, Dynamic> = query == null ? null : [];
		if (query != null)
			for (key in Reflect.fields(query))
				if (Reflect.field(query, key) != null)
					queryMap.set(key, Reflect.field(query, key));

		var apidata = client.call(method, endpoint, queryMap, data != null ? Json.stringify(data) : null, authType);

		var retval:APIResponse<R> = {};

		if (apidata.code != 204 && apidata.text != null) retval = Json.parse(apidata.text);
		retval.code = apidata.code;

		return retval;
	}
}
