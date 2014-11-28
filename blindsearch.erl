#!/usr/bin/env escript
%%! -pa ./ebin
-include("include/blindsearch.hrl").
main(_Arg)->
  blindsearch:run(dfs),
  blindsearch:run(dls),
  blindsearch:run(ids),
  blindsearch:run(bfs),
  blindsearch:run(ucs)
.
%% G1.


