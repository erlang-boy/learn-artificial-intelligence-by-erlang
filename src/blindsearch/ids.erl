%%%-------------------------------------------------------------------
%%% @author lhd
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Nov 2014 5:50 PM
%%%-------------------------------------------------------------------
-module(ids).
-author("lhd").

%% API
-export([ids/3]).

ids(G, From, To)->
  do(0, G, From, To).
do(Depth, G, From, To)->
  case dls:dls(G, From, To, Depth) of
    {found, R}-> {found, R};
           _  -> do(Depth +1, G, From, To)
  end.

