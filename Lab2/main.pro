implement main
    open core, stdio, file

domains
    id = integer.
    price = real.

class facts - factsDB
    издание : (id ID, string Title, string Type, price Price).
    подписчик : (id ID, string Name, integer Age, string Address).
    подписался : (id IDtitle, id IDperson, string Date, price SubscribtPrice).

class predicates
%Все подписчики определенного издания
    subscribers_of : (string Title).
%Стоимость издания
    price : (string Name).
%Кто на что подписан
    name_subscribed_on : (string Name).
    id_subscribed_on : (id ID).
    %Тип казеты
    type : (string Name).
%Сколько человеку c именем Name необходимо платеить за подписку( в неделю)
    subscribtion_price : (string Name).
%адреса подписчиков газеты
    addresses : (string Title).

clauses
    subscribers_of(Title) :-
        издание(Y, Title, _, _),
        подписался(Y, X, _, _),
        подписчик(X, Z, _, _),
        write(Z, ", "),
        write("\n"),
        fail.
    subscribers_of(_).

clauses
    price(Name) :-
        издание(_, Name, _, P),
        write(P, "\n"),
        fail.
    price(_).

clauses
    name_subscribed_on(Name) :-
        подписчик(ID1, Name, _, _),
        подписался(ID2, ID1, _, _),
        издание(ID2, Title, _, _),
        write(Title, "\n"),
        fail.
    name_subscribed_on(_).

clauses
    id_subscribed_on(ID) :-
        подписчик(ID, N, _, _),
        write(N, ": "),
        подписался(ID2, ID, _, _),
        издание(ID2, Name, _, _),
        write(Name, "\n"),
        fail.
    id_subscribed_on(_).

clauses
    type(Name) :-
        издание(_, Name, Type, _),
        write(Type, "\n"),
        fail.
    type(_).

clauses
    subscribtion_price(Name) :-
        подписчик(ID, Name, _, _),
        подписался(_, ID, _, P),
        write(P, "\n"),
        fail.
    subscribtion_price(_).

clauses
    addresses(Title) :-
        издание(ID, Title, _, _),
        подписался(ID, ID2, _, _),
        подписчик(ID2, _, _, Adress),
        write(Adress, ",  ", "\n"),
        fail.
    addresses(_).

clauses
    run() :-
        file::consult("../data.txt", factsDB),
        fail.

    run() :-
        write(
            "Газеты: The Times(1), The Guardian(2), The New York Times(3), The NewYorker(4),\nThe Financial Times(5), Daily Mail(6), The Telegraph(7),The Sun(8),Racing Post(9)\n"),
        write("Люди: John, Anna, Stuart, Edwin, Dmitry, Marina, Elena, Hanna, \nEmma, Sofia, Tatyana, Liana, Johny, Jimmy, Pavel, Georgiy\n"),
        write("Всего людей -- 16\n"),
        write("Введите название газеты, чтобы узнать ее подписчиков:\n"),
        Title = stdio::readLine(),
        subscribers_of(Title),
        write("Введите название газеты, чтобы узнать ее цену:\n"),
        T = stdio::readLine(),
        price(T),
        write("Введите имя человека, чтобы узнать на что он подписан:\n"),
        N = stdio::readLine(),
        name_subscribed_on(N),
        write("Введите ID человека, чтобы узнать на что он подписан:\n"),
        I = stdio::readLine(),
        id_subscribed_on(toTerm(I)),
        write("Введите название газеты, чтобы узнать ее тип:\n"),
        Tl = stdio::readLine(),
        type(Tl),
        write("Введите имя человека, чтобы узнать сколько соят его подписки на газеты:\n"),
        Nm = stdio::readLine(),
        subscribtion_price(Nm),
        write("Введите название газеты, чтобы узнать адреса ее читателей:\n"),
        Ttl = stdio::readLine(),
        addresses(Ttl),
        fail.
    run().

end implement main

goal
    console::runUtf8(main::run).
