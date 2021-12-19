meta(N, Objetivo) :- 0 is N mod Objetivo.

arc([N, ParentCost, _], Semente, Objetivo, [M, Cost, H]) :- 
    M is N * Semente, 
    Cost is 1 + ParentCost, 
    h(M, H, Objetivo).

arc([N, ParentCost, _], Semente, Objetivo, [M, Cost, H]) :- 
    M is N * Semente + 1, 
    Cost is 2 + ParentCost, 
    h(M, H, Objetivo).

h(N, Hvalue, Objetivo) :- 
    meta(N, Objetivo), 
    !, 
    Hvalue is 0;
    Hvalue is 1 / N.

busca(Lista_nos, _, Objetivo, [Node, Cost]) :- 
        min(Lista_nos, [[Node, Cost, _]|_]), 
        meta(Node, Objetivo).

busca(Lista_nos, Semente, Objetivo, F) :- 
    min(Lista_nos, [Node|FRest]),
    setof(NovoNo, arc(Node, Semente, Objetivo, NovoNo), FNode),
    append(FNode, FRest, FNew),
    busca(FNew, Semente, Objetivo, F).

min([H|T], Result) :- 
    hdMin(H, [], T, Result).
    hdMin(H, S, [], [H|S]).

hdMin(C, S, [H|T], Result) :- 
    menorQue(C, H), !, 
    hdMin(C, [H|S], T, Result);
    hdMin(H, [C|S], T, Result).

menorQue([_, Cost1, H1], [_, Cost2, H2]) :- 
    F1 is Cost1 + H1, 
    F2 is Cost2 + H2,
    F1 =< F2.

aEstrela(Inicio, Semente, Objetivo, Encontrado) :- 
    busca([[Inicio, 0, 0]], Semente, Objetivo, Encontrado).