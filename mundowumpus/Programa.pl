:- dynamic ([
        pos_agente/1,
        pos_ouro/1,
        pos_buraco/1,
        pos_wumpus/1,
        score/1,
        dimensao/1,
        visitado/1,
        visitado_campo/1,
        eh_burado/2,
        eh_wumpus/2,
        eh_ouro/2]).

principal:-
    inicializar,
    caminhar().

inicializar:- 
    assert(dimensao([4,4])),
    assert(pos_ouro([3,2])),
    assert(pos_wumpus([4,1])),
    assert(pos_buraco([4,4])),
    assert(pos_buraco([3,3])),
    assert(pos_buraco([1,3])),
    assert(pos_agente([1,1])).
    

caminhar():-
    obter_percepcao(Percepcao),
    atualizar_conhecimento(Percepcao),
    perguntar(Acao).

/*      Base de c1onhecimento        */
perguntar(Acao):-
    eh_wumpus(nao, L),
    eh_burado(nao, L),
    permitido(L),
    autualizar_pos(L),
    Acao = L.

atualizar_conhecimento([Fedor, Brisa, Brilho]):-
    add_wampus_kb(Fedor),
    add_brisa_kb(Brisa),
    add_ouro_kb(Brilho).  

add_wampus_kb(nao):- 
    pos_agente([X,Y]),
    Y1 is Y+1, gravar_wumpus(nao, [X,Y1]),
    Y2 is Y-1, gravar_wumpus(nao, [X,Y2]),
    X1 is X+1, gravar_wumpus(nao, [X1,Y]),
    X2 is X-1, gravar_wumpus(nao, [X2,Y]).

add_brisa_kb(nao):- 
    pos_agente([X,Y]),
    Y1 is Y+1, gravar_brisa(nao, [X,Y1]),
    Y2 is Y-1, gravar_brisa(nao, [X,Y2]),
    X1 is X+1, gravar_brisa(nao, [X1,Y]),
    X2 is X-1, gravar_brisa(nao, [X2,Y]).

add_ouro_kb(nao):- 
    pos_agente([X,Y]),
    gravar_ouro(nao, [X,Y]).

add_ouro_kb(sim):- 
    pos_agente([X,Y]),
    gravar_ouro(sim, [X,Y]).

gravar_wumpus(nao, Pos):-
    retractall(eh_wumpus(_, Pos)),
    assert(eh_wumpus(nao, Pos)).

gravar_brisa(nao, Pos):-
    retractall(eh_burado(_, Pos)),
    assert(eh_burado(nao, Pos)).

gravar_ouro(nao, Pos):-
    retractall( eh_ouro(_, Pos)),
    assert(eh_ouro(nao, Pos)).

gravar_ouro(sim, Pos):-
    retractall( eh_ouro(_, Pos)),
    assert(eh_ouro(sim, Pos)).

autualizar_pos(Pos):-
    retractall(pos_agente(Pos)),
    assert(pos_agente(Pos)).

/*      Sensores        */
obter_percepcao([Fedor, Brisa, Brilho]):-
    cheirar(Fedor),
    sentir(Brisa),
    enchergar(Brilho).

cheirar(sim):-
    pos_agente(Pa),
    pos_wumpus(Pw),
    adj(Pa, Pw).
cheirar(nao).

sentir(sim):-
    pos_agente(Pa),
    pos_buraco(Pb),
    adj(Pa,Pb).
sentir(nao).

enchergar(sim):-
    pos_agente(Pa),
    pos_ouro(Pa).
enchergar(nao).

/*      Util        */
adj([Xa,Ya],[Xb,Yb]):-
    Xa = Xb+1, Ya = Yb+1,
    Xa = Xb+1, Ya = Yb-1,
    Xa = Xb-1, Ya = Yb+1,
    Xa = Xb-1, Ya = Yb-1.

validaPosicao(X,Y):-
    dimensao([Px,Py]),
    X > 0, X =< Px,
    Y > 0, Y =< Py.

permitido([X,Y]):-
    dimensao([Dx,Dy]),
    0 < X, X < Dx+1,
    0 < Y, Y < Dy+1.

/*      Atuadores       */

/**
escolher():-
    random_between(1, 4, R),
    print(R).
   */ 

    