-module(seasonal).
-export([closeness/1]).
-export([closenessAll/0]).
-export([season/1]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Find the seasonal closeness
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
closenessAll() -> 
	lists:foreach(fun(S) -> 
		[{S2,_}|_] = lists:keysort(2,
			closeness_(S,lists:delete(S,seasons()),[])),
		io:format("~s : ~p ~n",[S,S2]) 
		end,seasons()).

closeness(Season) ->
	pretty_print(lists:keysort(2,
		closeness_(Season,lists:delete(Season,seasons()),[]))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Seasons and their dimensions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
season(dark_autumn) -> {dark,warm_neutral,medium_high};
season(dark_winter) -> {dark,cool_neutral,medium_high};
season(true_winter) -> {medium,cool,medium_high};
season(bright_winter) -> {medium,cool_neutral,high};
season(bright_spring) -> {medium,warm_neutral,high};
season(true_spring) -> {medium,warm,medium_high};
season(light_spring) -> {light,warm_neutral,medium};
season(light_summer) -> {light,cool_neutral,medium};
season(true_summer) -> {medium,cool,medium};
season(soft_summer) -> {medium,cool_neutral,low};
season(soft_autumn) -> {medium,warm_neutral,low};
season(true_autumn) -> {medium,warm,medium}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Run thru the seasons and match
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
closeness_(_,[],L) -> L;
closeness_(Season1,[Season2|Rest],L) -> 
	{Value1,Hue1,Chroma1} = season(Season1),
	{Value2,Hue2,Chroma2} = season(Season2),
	V = abs(calcValue(Value1) - calcValue(Value2)),
	H = abs(calcHue(Hue1) - calcHue(Hue2)),
	C = abs(calcChroma(Chroma1) - calcChroma(Chroma2)),
	Sum = V + H + C,
	closeness_(Season1,Rest,[{Season2,Sum}|L]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Map dimensions to sth calculable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
calcValue(dark) -> 1;
calcValue(medium) -> 2;
calcValue(light) -> 3.

calcHue(warm) -> 1;
calcHue(warm_neutral) -> 2;
calcHue(cool_neutral) -> 3;
calcHue(cool) -> 4.

calcChroma(low) -> 1;
calcChroma(medium) -> 2;
calcChroma(medium_high) -> 3;
calcChroma(high) -> 4.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Initialize all the seasons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
seasons() ->
	[dark_autumn,dark_winter,true_winter,bright_winter,
	bright_spring,true_spring,light_spring,light_summer,
	true_summer,soft_summer,soft_autumn,true_autumn].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Pretty print final list 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pretty_print(L) ->
	lists:foreach(fun({A,B}) -> 
		io:format("~s : ~p ~n",[A,B]) 
		end, L).
		
