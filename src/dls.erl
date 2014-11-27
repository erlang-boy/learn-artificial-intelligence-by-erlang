%%%-------------------------------------------------------------------
%%% @author lhd
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Nov 2014 4:42 PM
%%%-------------------------------------------------------------------
-module(dls).
-author("lhd").

%% API
-export([dls/4]).
dls(G, From, To, Limit)->
  Stack = queue:new(),
  DStack = queue:new(),
  Stack1 = queue:in(From, Stack),
  DStack1 = queue:in(0, DStack),
  do(G, Stack1, DStack1, To, Limit, queue:is_empty(Stack1),[]).

do(_G, _Stack, _DStack, _To, _Limit, found, Acc)->
  {found, lists:reverse(Acc)};
do(_G, _Stack, _DStack, _To, _Limit, true, Acc)->
  {not_find, lists:reverse(Acc)};
do(G, Stack, DStack, To, Limit, false, Acc)->
  {{value, Item}, Stack1} = queue:out_r(Stack),
  {{value, Depth}, DStack1} = queue:out_r(DStack),
  case Item =:= To of
    true->
      do(G, Stack1, DStack1, To, Limit, found, [Item |Acc]);
    false->
      {Stack2, DStack2} = case Depth < Limit of
                            true->
                              do1(round(math:sqrt(array:size(G))-1), Item, Stack1, Depth, DStack1, G);
                            false->
                              {Stack1, DStack1}
                          end,
      do(G, Stack2, DStack2, To, Limit, queue:is_empty(Stack2), [Item |Acc])
  end.
do1(0, _Item, Stack, _Depth, DStack, _G)->
  {Stack, DStack};
do1(N, Item, Stack, Depth, DStack, G)->
  case blindsearch_utils:getEdge(G, Item, N) of
    1->
      do1(N-1, Item, queue:in(N, Stack), Depth, queue:in(Depth +1, DStack),  G);
    0->
      do1(N-1, Item, Stack, Depth, DStack,  G)
  end.
