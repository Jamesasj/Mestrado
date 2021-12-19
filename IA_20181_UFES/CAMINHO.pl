dynamic lista/1.
lista([]).

tests1:-
    Arvore = [a,[b,[d,e]],[c,[f,g]]],
    caminhar(Arvore).

esqueda([X,R|T]):- 
    caminhar(R),
    write(" \nCaminha centro esquerda "),
    write(X),
    add(X).
    

direita([X,R|T]):- 
    caminhar(R),
    write(" \nCaminha centro direita "), 
    write(X),
    add(X).

caminhar([X, E, D|A]):- 
    esqueda(E), 
    direita(D),
    write(" \nCaminha centro: "), 
    add(X),
    write(X),
    !.

caminhar([E, D| T]):-  
    write(" \nFim Esquerda: "), 
    write(E),
    add(E),
    write(" \nFim Direita: "), 
    write(D),
    add(D),
    !. 

caminhar([]):- 
    write(" Fim "),
    !.

add(X):-
    write("\n Adicionar "),
    retract(lista(LOrdem)),
    write(LOrdem),
    append(LOrdem,[X],NLista),
    asserta(lista(NLista)).    
