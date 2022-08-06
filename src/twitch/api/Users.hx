package twitch.api;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

/**
  Endpoints pertaining to users, including blocking them.

  This currently excludes `GetUserActiveExtensions` and `UpdateUserExtensions`, which have more complex responses.
**/
@:build(twitch.api.APIBuilder.build("users"))
class Users {
}
