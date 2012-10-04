-module(reg_server_tests).

-include_lib("eunit/include/eunit.hrl").

-export([scenarios/0, test/0]).

scenarios() ->
    [{test, inf}].

test() ->
    start_test(),
    ping_test().

start_test() ->
    ?assertEqual(ok, reg_server:start()).

ping_test() ->
    reg_server:start(),
    ?assertEqual(pong, reg_server:ping()),
    ?assertEqual(pong, reg_server:ping()).
