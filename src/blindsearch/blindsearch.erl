%%%-------------------------------------------------------------------
%%% @author lhd
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Nov 2014 4:36 PM
%%%-------------------------------------------------------------------
-module(blindsearch).
-author("lhd").
-include("../include/blindsearch.hrl").

%% API
-export([run/1]).

run(dfs)->
  G = blindsearch_utils:createGraph(8),
  G1 = blindsearch_utils:init_G(G),
  R =dfs:dfs(G1, ?A, ?F),
  print_result(dfs, R);

run(dls)->
  G = blindsearch_utils:createGraph(8),
  G1 = blindsearch_utils:init_G(G),
  R = dls:dls(G1, ?A, ?F, 1),
  print_result(dls, R);
run(ids)->
  G = blindsearch_utils:createGraph(8),
  G1 = blindsearch_utils:init_G(G),
  R = ids:ids(G1, ?A, ?F),
  print_result(ids, R);

run(bfs)->
  G = blindsearch_utils:createGraph(8),
  G1 = blindsearch_utils:init_G(G),
  R = bfs:bfs(G1, ?A, ?F),
  print_result(bfs, R);

run(ucs)->
  G = blindsearch_utils:createGraph(5),
  G1 = blindsearch_utils:init_G(G, ucs),
  R = ucs:ucs(G1, ?A, ?E),
  print_result(ucs, R)
.

print_result(Who,{F, R})->
  io:format("~p ~p:~p~n",[Who,F, lists:concat([blindsearch_utils:f(X)|| X<-R])]).