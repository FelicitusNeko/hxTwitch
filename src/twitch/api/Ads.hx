package twitch.api;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

@:build(twitch.api.APIBuilder.build("ads"))
class Ads {
	static public function ModelStartCommerical(client:Client,
			body:{broadcaster_id:String, length:Int}):APIResponse<{length:Int, message:String, retry_after:String}> {
		trace("Bravo, you win!");
		return {
			data: {
				length: body.length,
				message: "whaaaat",
				retry_after: "Never"
			}
		}
	}
}
