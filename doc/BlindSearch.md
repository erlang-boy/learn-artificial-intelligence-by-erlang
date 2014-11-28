盲目搜索
=========

* dfs算法是一种穷举算法，目标节点在图中不存在，则算法将终止，但在这之前会搜索图中每个节点[参考erlang代码](../src/blindsearch.erl)

        run(dfs)->
        G = blindsearch_utils:createGraph(8),
        G1 = blindsearch_utils:init_G(G),
        R =dfs:dfs(G1, ?A, ?F),
        print_result(dfs, R);

        X|A|B|C|D|E|F|G|H
        A|0|1|1|0|0|0|0|0
        B|0|0|0|1|0|0|0|0
        C|0|0|0|0|1|1|0|0
        D|0|0|0|0|0|0|1|1
        E|0|0|0|0|0|0|0|0
        F|0|0|0|0|0|0|0|0
        G|0|0|0|0|0|0|0|0
        H|0|0|0|0|0|0|0|0
        dfs found:"ABDGHCEF"



* dls算法是dfs算法的一种改进,超过预设深度就会终止，避免有回路时陷入无限循环[参考erlang代码](../src/blindsearch.erl)

        run(dls)->
        G = blindsearch_utils:createGraph(8),
        G1 = blindsearch_utils:init_G(G),
        R = dls:dls(G1, ?A, ?F, 1),
        print_result(dls, R);


        X|A|B|C|D|E|F|G|H
        A|0|1|1|0|0|0|0|0
        B|0|0|0|1|0|0|0|0
        C|0|0|0|0|1|1|0|0
        D|0|0|0|0|0|0|1|1
        E|0|0|0|0|0|0|0|0
        F|0|0|0|0|0|0|0|0
        G|0|0|0|0|0|0|0|0
        H|0|0|0|0|0|0|0|0
        dls not_find:"ABC"


* ids算法是dls算法的一种衍生算法,他不会受到回路影响还能找到离根节点最近的目标节点[参考erlang代码](../src/blindsearch.erl)

        run(ids)->
        G = blindsearch_utils:createGraph(8),
        G1 = blindsearch_utils:init_G(G),
        R = ids:ids(G1, ?A, ?F),
        print_result(ids, R)

        X|A|B|C|D|E|F|G|H
        A|0|1|1|0|0|0|0|0
        B|0|0|0|1|0|0|0|0
        C|0|0|0|0|1|1|0|0
        D|0|0|0|0|0|0|1|1
        E|0|0|0|0|0|0|0|0
        F|0|0|0|0|0|0|0|0
        G|0|0|0|0|0|0|0|0
        H|0|0|0|0|0|0|0|0
        ids found:"ABDCEF"

* bfs算法是从根节点开始，并按照距离根节点的远近对图进行搜索，使用队列实现，在非带权的图中，一定能找到最佳可能解[参考erlang代码](../src/blindsearch.erl)

        run(bfs)->
        G = blindsearch_utils:createGraph(8),
        G1 = blindsearch_utils:init_G(G),
        R = bfs:bfs(G1, ?A, ?F),
        print_result(bfs, R)

        X|A|B|C|D|E|F|G|H
        A|0|1|1|0|0|0|0|0
        B|0|0|0|1|0|0|0|0
        C|0|0|0|0|1|1|0|0
        D|0|0|0|0|0|0|1|1
        E|0|0|0|0|0|0|0|0
        F|0|0|0|0|0|0|0|0
        G|0|0|0|0|0|0|0|0
        H|0|0|0|0|0|0|0|0
        bfs found:"ACBF"

* ucs算法是基于bfs算法，使用一个按照路径代价进行排序的优先队列对图进行搜索，既是完备的，又是最优的（完备是说，只要有就能找到，最优为，代价最小）[参考erlang代码](../src/blindsearch.erl)

        run(ucs)->
        G = blindsearch_utils:createGraph(5),
        G1 = blindsearch_utils:init_G(G, ucs),
        R = ucs:ucs(G1, ?A, ?E),
        print_result(ucs, R)

        X|A|B|C|D|E
        A|0|5|1|2|0
        B|0|0|0|0|1
        C|0|0|0|0|7
        D|0|0|0|0|5
        E|0|0|0|0|0
        ucs found:"ACDBE"

##综述：

   * 这类算法都是进行的一种蛮力搜索，因此效率低下，有了启发式搜索，下章继续





