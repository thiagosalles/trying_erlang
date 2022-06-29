trying_erlang
=============

References:
- https://www.erlang.org/doc/getting_started/intro.html

# Erlang Shell Commands

Open the shell with the comand `erl`.

- Commands need to end with a full stop ".": `1 + 2.`
- To compile a module: `c(<module_name>).`
	- Example: `c(tut).`
- To call a function: `<module_name>:<function_name>(<arguments>).`
	- Example: `tut:double(2).`


# Erlang Style

- Variables start with an uppercase letter or underscore: `Name = "Thiago".`
- Atoms start with a small letter: `Module = tut`
- Variables are bound to values using pattern matching. Erlang uses single assignment, that is, a variable can only be bound once.
	```erlang
	1> Module = tut.
	tut
	2> Module = tut1.
	** exception error: no match of right hand side value tut1
	3> 
	```
- It's possible call functions using expressions if they evaluate to atoms.
	```erlang
	1> x(tut1).
	{ok,tut1}
	2> Module = tut1.
	tut1
	3> Function = mult.
	mult
	4> Module:Function(2, 3).
	6
	```
- Referencing functions:
	```erlang
	1> Function = fun(X) -> X + 1 end.
	#Fun<erl_eval.7.126501267>
	2> Function(7).
	8
	3> c(tut1).  
	{ok,tut1}
	4> Function2 = fun tut1:mult/2.
	fun tut1:mult/2
	5> Function2(3,7).
	21
	6> 
	```
- Term Comparisons
	- Exactly equal to: `=:=`
		```erlang
		1> 5 == 5.0. 
		true
		2> 5 =:= 5.0.
		false
		```
	- Exactly not equal to: `/=`
		```erlang
		1> 5 /= 5.0.
		false
		2> 5 =/= 5.0.
		true
		```
- Arithmetic Expressions
	- Floating point division: `/`
		```erlang
		1> 5 / 2.
		2.5
		```
	- Integer division: `div`
		```erlang
		1> 5 div 2.
		2
		```
- Short-Circuit Expressions
	- Expr2 is evaluated only if necessay
		- `orelse`
		- `andalso`
		```erlang
		1> Function1 = fun(X) -> (X >= 0) andalso (math:sqrt(X) > 0) end.
		#Fun<erl_eval.7.126501267>
		2> Function1(-1).
		false
		3> Function2 = fun(X) -> (X >= 0) and (math:sqrt(X) > 0) end.
		#Fun<erl_eval.7.126501267>
		4> Function2(-1).
		** exception error: an error occurred when evaluating an arithmetic expression
		     in function  math:sqrt/1
		        called as math:sqrt(-1)
		```