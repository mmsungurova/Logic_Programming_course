implement main
    open core, stdio, file

class facts
    издание : (integer ID, string Title, string Type, real Price).
    подписчик : (integer ID, string Name, integer Age, string Address).
    подписался : (integer IDtitle, integer IDperson, string Date, real SubscribtPrice).

clauses
    издание(1, "The Times", "Daily newspaper", 2.50).
    издание(2, "The Guardian", "Daily newspaper", 3).
    издание(3, "The New York Times", "Daily newspaper", 2.75).
    издание(4, "The NewYorker", "Weekly magazine", 2.25).
    издание(5, "The Financial Times", "Business&Finance", 4).
    издание(6, "Daily Mail", "Daily newspaper", 2).
    издание(7, "The Telegraph", "Daily newspaper", 2.85).
    издание(8, "The Sun", "Daily newspaper", 1.75).
    издание(9, "Racing Post", "Daily racing&sports newspaper", 3.50).

    подписчик(1, "John", 34, "30 Lake Drive Brooklyn, NY 11201").
    подписчик(2, "Anna", 27, "15 Myrtle Lane New York, NY 10040").
    подписчик(3, "Stuart", 29, "17 Myrtle Lane New York, NY 10040").
    подписчик(4, "Edwin", 40, "7399 Belmont Drive Brooklyn, NY 11218").
    подписчик(5, "Dmitry", 41, "2 Pawnee Dr.Bronx, NY 10460").
    подписчик(6, "Marina", 53, "4 Chester Road London SW14 8ZY").
    подписчик(7, "Elena", 30, "68 Alexander Road London EC97 1WZ").
    подписчик(8, "Hanna", 59, "6 The Avenue London WC08 7NT").
    подписчик(9, "Emma", 28, "30 Lake Drive Brooklyn, NY 11201").
    подписчик(10, "Sofia", 26, "114 Broadway London WC92 3LT").
    подписчик(11, "Tatyana", 38, "Ovchinnikovskaya Naberezhnaya, 22 стр1, Moscow, Russia").
    подписчик(12, "Liana", 29, "New Arbat Ave, 50, Moscow, Russia").
    подписчик(13, "Johny", 44, "Gagarinskiy Pereulok, 65, Moscow, Russia").
    подписчик(14, "Jimmy", 37, "Kropotkinskiy Pereulok, 92, Moscow, Russia").
    подписчик(15, "Pavel", 37, "Malaya Bronnaya St, 65, Moscow, Russia").
    подписчик(16, "Georgiy", 26, "Myasnitskaya Ulitsa, 99, Moscow, Russia").

    %Подписка за неделю
    подписался(1, 3, "12.10.2018", 23.5).
    подписался(1, 2, "12.10.2018", 23.5).
    подписался(1, 5, "20.10.2015", 23.5).

    подписался(2, 1, "23.04.2010", 26).
    подписался(2, 4, "03.03.2016", 26).
    подписался(2, 15, "03.03.2016", 26).
    подписался(2, 13, "03.03.2016", 26).

    подписался(3, 6, "12.11.2018", 10).
    подписался(3, 7, "11.07.2019", 10).
    подписался(3, 9, "11.07.2019", 10).

    подписался(4, 8, "20.12.2019", 25).
    подписался(4, 4, "02.03.2020", 25).
    подписался(4, 12, "20.06.2020", 25).

    подписался(5, 6, "15.05.2019", 23.75).
    подписался(5, 7, "24.03.2021", 23.75).
    подписался(5, 10, "24.03.2021", 23.75).
    подписался(5, 11, "24.03.2021", 23.75).
    подписался(5, 16, "24.03.2021", 23.75).

    подписался(6, 13, "05.06.2021", 23.5).
    подписался(6, 15, "03.04.2022", 23.5).
    подписался(6, 2, "22.09.2021", 23.5).

    подписался(7, 3, "09.05.2020", 15).
    подписался(7, 5, "07.11.2019", 15).
    подписался(7, 9, "09.05.2020", 15).

    подписался(8, 14, "20.02.2023", 9.56).
    подписался(8, 10, "04.01.2023", 9.56).
    подписался(8, 4, "04.01.2023", 9.56).

    подписался(9, 16, "24.06.2018", 20).
    подписался(9, 11, "25.10.2017", 20).
    подписался(9, 2, "25.10.2017", 20).
    подписался(9, 1, "25.10.2017", 20).

class predicates
%Все подписчики определенного издания
    subscribers_of : (string Title).
%Стоимость издания
    price : (string Name).
%Кто на что подписан
    name_subscribed_on : (string Name).
    id_subscribed_on : (integer ID).
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
