creeEn(gabriel, campanita).
creeEn(gabriel, magoDeOz).
creeEn(gabriel, cavenaghi).
creeEn(juan, conejoDePascua).
creeEn(macarena, reyesMagos).
creeEn(macarena, magoCapria).
creeEn(macarena, campanita).

sueniaCon(juan,cantante(100000)).
sueniaCon(gabriel,futbolista(arsenal)).
sueniaCon(gabriel,ganarLoteria([5,9])).
sueniaCon(macarena,cantante(10000)).


%Punto 1:
ambiciosa(Persona):-
    sueniaCon(Persona,_),
    findall(Dificultad, dificultadDeSuenio(Persona, Dificultad), Dificultades),
    sum_list(Dificultades, DificultadTotal),
    DificultadTotal > 20.

dificultadDeSuenio(Persona, Dificultad):-
    sueniaCon(Persona, Suenio),
    dificultadSuenio(Suenio, Dificultad).

dificultadSuenio(cantante(CantidadDiscos), Dificultad):-
    dificultadSegunCantidadDeDiscos(CantidadDiscos, Dificultad).
dificultadSuenio(ganarLoteria(Numeros), Dificultad):-
    length(Numeros,CantidadNumeros),
    Dificultad is 10 * CantidadNumeros.
dificultadSuenio(futbolista(Equipo), Dificultad):-
    dificultadSegunTipoDeEquipo(Equipo, Dificultad).

dificultadSegunCantidadDeDiscos(Cantidad, 6):-
    Cantidad > 500000.
dificultadSegunCantidadDeDiscos(Cantidad, 4):-
    not(Cantidad > 500000).

dificultadSegunTipoDeEquipo(Equipo,3):-
    equipoChico(Equipo).
dificultadSegunTipoDeEquipo(Equipo, 16):-
    not(equipoChico(Equipo)).

equipoChico(Equipo):-
    member(Equipo, [arsenal, aldosivi]).
    
%Punto 3:
tieneQuimica(Personaje, Persona):-
    creeEn(Persona, Personaje),
    requisitosQuimicos(Persona, Personaje).

requisitosQuimicos(Persona, campanita):-
    dificultadDeSuenio(Persona,Dificultad),
    Dificultad < 5.
requisitosQuimicos(Persona, Personaje):-
    Personaje \= campanita,
    forall(sueniaCon(Persona, Suenio), esPuro(Suenio)),
    not(ambiciosa(Persona)).


esPuro(futbolista(_)).
esPuro(cantante(Cantidad)):-
    Cantidad < 200000.

%Punto 4:
amigaDe(campanita, reyesMagos).
amigaDe(campanita, conejoDePascua).
amigaDe(conejoDePascua, cavenaghi).

puedeAlegrar(Personaje, Persona):-
    sueniaCon(Persona,_),
    tieneQuimica(Personaje, Persona),
    noEstaEnfermoOAlgunBackupNoEstaEnfermo(Personaje).

noEstaEnfermoOAlgunBackupNoEstaEnfermo(Personaje):-
    not(enfermo(Personaje)).
noEstaEnfermoOAlgunBackupNoEstaEnfermo(Personaje):-
    amigaDe(Personaje, Amigo),
    noEstaEnfermoOAlgunBackupNoEstaEnfermo(Amigo).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoDePascua).