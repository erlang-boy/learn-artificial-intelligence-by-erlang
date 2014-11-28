%%%-------------------------------------------------------------------
%%% @author lhd
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Nov 2014 10:19 PM
%%%-------------------------------------------------------------------
-module(ucs).
-author("lhd").

%% API
-export([ucs/3]).

ucs(G, From, To)->
  Stack = queue:new(),
  Stack1 = queue:in({From, 0}, Stack),
  do(G, Stack1, To, queue:is_empty(Stack1), []).

do (_G, _Stack, _To, found, Acc)->
  {found, lists:reverse(Acc)};
do (_G, _Stack, _To, true, Acc)->
  {not_find, lists:reverse(Acc)};
do (G, Stack, To, false, Acc)->
  {{value, {Item, Cost}}, Stack1} = queue:out(queue:from_list(lists:keysort(2,queue:to_list(Stack)))),
  case Item =:= To of
    true->
      do(G, Stack1, To, found, [Item|Acc]);
    false->
      Stack2 = do1(round(math:sqrt(array:size(G))-1), {Item, Cost}, Stack1, G),
      do(G, Stack2, To, queue:is_empty(Stack2), [Item|Acc])
  end.
do1 (0, {_Item, _Cost}, Stack, _G)->
  Stack;
do1 (N, {Item, Cost}, Stack, G)->
  do1 (N-1, {Item, Cost}, case blindsearch_utils:getEdge(G, Item, N) of
                        0->Stack;
                        O-> queue:in({N, Cost+ O}, Stack)
                  end, G).