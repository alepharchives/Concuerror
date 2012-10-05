-module(reg_server).

-export([start/0, stop/0, ping/0]).

-define(REG_NAME, reg_server).
-define(REG_REQUEST, reg_request).
-define(REG_REPLY, reg_reply).

start() ->
    Pid = spawn(fun() -> loop() end),
    register(?REG_NAME, Pid),
    ok.

stop() ->
    request(stop).


ping() ->
    request(ping).

loop() ->
    receive
    {?REG_REQUEST, Target, ping} ->
        reply(Target, pong),
        loop();
    {?REG_REQUEST, Target, stop} ->
        reply(Target, ok)
    end.

request(Request) ->
    ?REG_NAME ! {?REG_REQUEST, self(), Request},
    receive
    {?REG_REPLY, Reply} -> Reply
    end.

reply(Target, Reply) ->
    Target ! {?REG_REPLY, Reply}.

