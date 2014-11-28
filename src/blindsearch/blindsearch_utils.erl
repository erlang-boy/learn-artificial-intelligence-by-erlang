%%%-------------------------------------------------------------------
%%% @author lhd
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Nov 2014 4:33 PM
%%%-------------------------------------------------------------------
-module(blindsearch_utils).
-author("lhd").
-include("../include/blindsearch.hrl").

%% API
-export([init_G/1, init_G/2, createGraph/1, addEdge/4, getEdge/3, f/1]).
init_G(G)->
  List = [{?A,?B},{?A,?C},{?B,?D},{?C,?E},{?C,?F},{?D,?G},{?D,?H}],
  init_G(G,List).
init_G(G, ucs)->
  List = [{?A,?B, 5},{?A,?C, 1},{?A,?D, 2},{?B,?E, 1},{?C,?E, 7},{?D,?E, 5}],
  init_G(G,List);
init_G(G,[])->
  print_l(array:size(G)-1,G,[]),
  G;
init_G(G,[{X, Y}|T])->
  init_G(addEdge(G,X,Y,1),T);
init_G(G,[{X, Y, V}|T])->
  init_G(addEdge(G,X,Y,V),T).
f(?A)->"A";
f(?B)->"B";
f(?C)->"C";
f(?D)->"D";
f(?E)->"E";
f(?F)->"F";
f(?G)->"G";
f(?H)->"H";
f(X)->X.

print(X)->
  io:format(f(X)).
print_l(0, G, Acc)->
  O =lists:flatten([["~n",f(0),"|",integer_to_list(array:get(0, G))]|Acc]),
  Ps = lists:concat(lists:map(fun(X)->lists:append("|",X)  end ,[f(X)||X<-lists:seq(0,round(math:sqrt(array:size(G))-1))])),
  Result = lists:concat(["X",Ps, O]),
  print(Result++"~n");
print_l(N, G, Acc)->
  case {N rem round(math:sqrt(array:size(G))), N div round(math:sqrt(array:size(G)))} of
    {0, C}->
      print_l(N-1,G, [["~n",f(C),"|",integer_to_list(array:get(N, G))]|Acc]);
    _->
      print_l(N-1,G, [["|",integer_to_list(array:get(N, G))]|Acc])
  end.




createGraph(Nodes)->
  array:new(Nodes*Nodes,{default,0}).
addEdge(G, From, To, Value)->
  M = round(math:sqrt(array:size(G))),
  I = ?CELL(M, From, To),
  array:set(I, Value, G).
getEdge(G, From, To)->
  M = round(math:sqrt(array:size(G))),
  array:get(?CELL(M, From, To), G).