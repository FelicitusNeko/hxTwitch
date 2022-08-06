package twitch.api;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

/**
  Endpoints pertaining to the stream schedule and its segments.

  This currently excludes `GetChanneliCalendar`, as it returns plain text rather than a JSON object.
**/
@:build(twitch.api.APIBuilder.build("schedule"))
class Schedule {
}
