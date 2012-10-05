-module(test).

-include_lib("eunit/include/eunit.hrl").

-export([scenarios/0, start_test/0, ping_test/0]).

scenarios() ->
    [{start_test, inf}, {ping_test, inf}].

start_test() ->
    ?assertEqual(ok, reg_server:start()),
    ?assertEqual(ok, reg_server:stop()).

ping_test() ->
    reg_server:start(),
    ?assertEqual(pong, reg_server:ping()),
    ?assertEqual(pong, reg_server:ping()),
    reg_server:stop().
