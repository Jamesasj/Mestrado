teste1:-
    Pos_inicial = [2,2],
    Goal = [2,2],
    Universo = [2,2],
    movimentar(Pos_inicial,Goal,Universo, Caminho).

teste2:-
    Pos_inicial = [1,2],
    Goal = [2,2],
    Universo = [2,2],
    Caminho = [[1,1]],
    movimentar(Pos_inicial,Goal,Universo, Caminho).

teste3:-
    Pos_inicial = [3,2],
    Goal = [1,2],
    Universo = [3,2],
    Caminho = [],
    movimentar(Pos_inicial,Goal,Universo, Caminho).

teste4:-
    Pos_inicial = [3,2],
    Goal = [1,2],
    Universo = [3,2],
    Caminho = [[2,2]],
    movimentar(Pos_inicial,Goal,Universo, Caminho).

movimentar([Xa,Ya], G, U, C):- 
    dentro_do_universo([Xa,Ya],U),
    chegou_destino([Xa,Ya],G),
    write("solução"),nl,
    write(C),
    mostrar_h([Xa, Ya]).

movimentar([Xa,Ya], G, U, C):-
    write("Andar para direita"), nl,
    mostrar_h([Xa,Ya]),
    write(C), nl,
    dentro_do_universo([Xa,Ya],U),
    nao_caminho([Xa,Ya],C),
    Xd is Xa + 1,
    append([[Xa,Ya]],C,C1),
    movimentar([Xd,Ya],G,U,C1),
    mostrar_h([Xa,Ya]).

movimentar([Xa,Ya], G, U, C):- 
    write("Andar para Esqueda"), nl,
    mostrar_h([Xa,Ya]),
    write(C), nl,
    dentro_do_universo([Xa,Ya],U),
    nao_caminho([Xa,Ya],C),
    Xd is Xa - 1,
    append([[Xa,Ya]],C,C1),
    movimentar([Xd,Ya],G,U,C1),
    mostrar_h([Xa,Ya]).

movimentar([Xa,Ya], G, U, C):-
    write("Andar para baixo"), nl,
    mostrar_h([Xa,Ya]),
    write(C), nl,
    dentro_do_universo([Xa,Ya],U),
    nao_caminho([Xa,Ya],C),
    Yd is Ya + 1,
    append([[Xa,Ya]],C,C1),
    movimentar([Xa,Yd],G,U,C1).

movimentar([Xa,Ya], G, U, C):- 
    write("Andar  para cima"), nl,
    mostrar_h([Xa,Ya]),
    write(C), nl,
    dentro_do_universo([Xa,Ya],U),
    nao_caminho([Xa,Ya],C),
    Yd is Ya - 1,
    append([[Xa,Ya]],C,C1),
    movimentar([Xa,Yd],G,U,C1).

chegou_destino([Xa,Ya], [Xg,Yg]):- Xa = Xg, Ya = Yg.

dentro_do_universo([Xa,Ya], [Xu,Yu]):- write("  Dentro do universo"), nl, Xa =< Xu, Ya =< Yu, Xa > 0, Ya > 0.

posicao_igual([Xa,Ya],[]) :-     
    write("         posicao_igual fim da lista "), nl.

posicao_igual([Xa,Ya],[Xo, Yo]) :- 
    write("          compara posições posição"), nl, 
    Xa\=Xo; Ya\=Yo.

nao_caminho([Xa,Ya],[]):- 
    write("   Não caminho fim recursao"), nl.

nao_caminho([Xa,Ya],[O|C]):-
    write("   Não caminho cabeça recursao"), nl,
    write(C), nl, 
    posicao_igual([Xa,Ya],O),
    nao_caminho([Xa,Ya],C).

mostrar_h([H,P]):- write(H),write(","), write(P),nl.