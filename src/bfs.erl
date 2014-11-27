%%%-------------------------------------------------------------------
%%% @author lhd
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Nov 2014 9:18 PM
%%%-------------------------------------------------------------------
-module(bfs).
-author("lhd").

%% API
-export([bfs/3]).

bfs(G, From, To)->
  Stack = queue:new(),
  Stack1 = queue:in(From, Stack),
  do(G, Stack1, To, queue:is_empty(Stack1), []).

do (_G, _Stack, _To, found, Acc)->
  {found, lists:reverse(Acc)};
do (_G, _Stack, _To, true, Acc)->
  {not_find, lists:reverse(Acc)};
do (G, Stack, To, false, Acc)->
  {{value, Item}, Stack1} = queue:out(Stack),
  case Item =:= To of
    true->
      do(G, Stack1, To, found, [Item|Acc]);
    false->
      Stack2 = do1 (round(math:sqrt(array:size(G))-1), Item, Stack1, G),
      do(G, Stack2, To, queue:is_empty(Stack2), [Item|Acc])
  end.
do1 (0, _Item, Stack, _G)->
  Stack;
do1 (N, Item, Stack, G)->
  do1 (N-1, Item, case blindsearch_utils:getEdge(G, Item, N) of
                    1-> queue:in(N, Stack);
                    0->Stack
                  end, G).