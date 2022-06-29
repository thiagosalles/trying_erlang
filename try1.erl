-module(try1).
-export([
	test_fail/0,
	test_ok/0,
	is_greater_than/2,
	is_valid_signal/1,
	wait_for_command/0,
	wait_for_command/1
]).
-compile({no_auto_import, [length/1]}).

length(_) -> not_implemented.

test_fail() -> length([1, 2, 3]).

test_ok() -> erlang:length([1, 2, 3]).

is_greater_than(X, Y) ->
	if
		X > Y ->
			Result = true,
			Result;
		true -> % works as an 'else' branch
			false
	end.

is_valid_signal(Signal) ->
	case Signal of
		{signal, _What, _From, _To} ->
			true;
		{signal, _What, _To} ->
			true;
		_Else ->
			false
	end.

wait_for_command() ->
	spawn(try1, wait_for_command, [self()]).

wait_for_command(Pid) ->
	receive
		{test, fail = Cmd} -> 
			io:format("Command received: ~p~n", [Cmd]),
			Result = test_fail(),
			io:format("Result: ~p~n", [Result]),
			wait_for_command(Pid);
		{test, ok = Cmd} ->
			io:format("Command received: ~p~n", [Cmd]),
			Result = test_ok(),
			io:format("Result: ~p~n", [Result]),
			wait_for_command(Pid);
		Message ->
			io:format("Invalid message received: ~p~n", [Message]),
			wait_for_command(Pid)
	after
		10000 ->
			io:format("No message received after 10s of inactivity.~n"),
			io:format("Retrying...~n"),
			wait_for_command(Pid)
	end.