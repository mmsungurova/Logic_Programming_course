implement main
    open core, stdio, file

domains
    id = integer.
    price = real.
    strlist = string*.
    rlist = real*.
    intlist = integer*.

class facts - factsDB
    издание : (id ID, string Title, string Type, price Price).
    подписчик : (id ID, string Name, integer Age, string Address).
    подписался : (id IDtitle, id IDperson, string Date, price SubscribtPrice).

% ------------------------------Лабораторная 2----------------------------------------------
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

%L = [Price || издание(_,_,_,Price), Price > 2],
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

%  ----------------------------Лабораторная 3----------------------------------------
class predicates
    exclude : (intlist Source, intlist Excludeble, intlist Result [out]).
    exclude_element : (integer El_excl, intlist List, intlist Result [out]).

clauses
    exclude(List, [], List).
    exclude(List, [N | T], Result) :-
        exclude_element(N, List, R),
        exclude(R, T, Result),
        write(Result).

    exclude_element(_, [], []).
    exclude_element(N, [N | T], T) :-
        !.
    exclude_element(N, [Y | T], [Y | Tr]) :-
        exclude_element(N, T, Tr).

class predicates
    add_front : (integer Element, intlist List, intlist NewList [out]).
clauses
    add_front(Element, List, [Element | List]).

class predicates
    add_back : (integer Element, intlist List, intlist NewList [out]).
clauses
    add_back(Element, [], [Element]).
    add_back(Element, [H | T], [H | NewT]) :-
        add_back(Element, T, NewT).

class predicates
    %  print_list : (integer Elt).
    print_list : (strlist List) determ.
clauses
    print_list([H]) :-
        write(H, ".\n"),
        !.
    print_list([H | T]) :-
        write(H, ", "),
        print_list(T).

class predicates
    max_price : (rlist List, real Max [out]) determ.
    max : (real I1, real I2, real Max [out]).

clauses
    max(H1, H2, Max) :-
        if H1 > H2 then
            Max = H1
        else
            Max = H2
        end if.
    max_price([H], Max) :-
        Max = H.
    max_price([H1, H2 | T], Max) :-
        max_price(T, Max1),
        max(H1, H2, Max2),
        max(Max1, Max2, Max3),
        Max = Max3.

class predicates
    min_price : (rlist List, real Min [out]) determ.
    min : (real I1, real I2, real Min [out]).

clauses
    min(H1, H2, Min) :-
        if H1 < H2 then
            Min = H1
        else
            Min = H2
        end if.
    min_price([H], Min) :-
        Min = H.
    min_price([H1, H2 | T], Min) :-
        min_price(T, Min1),
        min(H1, H2, Min2),
        min(Min1, Min2, Min3),
        Min = Min3.

class predicates
    find_man : (string Name, strlist List, string Res [out]) nondeterm.
    is_man : (string Name, string Last, string Res [out]).
    find_man_interface : (string Res).

clauses
    is_man(Name, H, Res) :-
        if Name = H then
            Res = "True"
        else
            Res = "False"
        end if.
    find_man(Name, [T], Res) :-
        is_man(Name, T, Res).
    find_man(Name, [H | T], Res) :-
        is_man(Name, H, Res1),
        find_man(Name, T, Res2),
        if Res1 = "True" or Res2 = "True" then
            Res = "True"
        else
            Res = "False"
        end if.

    find_man_interface(Res) :-
        if Res = "True" then
            write("Человек с таким именем есть в списке подписчиков\n")
        elseif Res = "False" then
            write("Человека с таким именем нет в списке подписчиков\n")
        end if.

class facts
    summa : (real Sum) single.

class predicates
    subscriptions_per_month_sum : (rlist List, real Res [out]).
clauses
    summa(0).
    subscriptions_per_month_sum([], Res) :-
        summa(Res),
        !.
    subscriptions_per_month_sum([H | T], Res) :-
        summa(Sum),
        assert(summa(Sum + H)),
        subscriptions_per_month_sum(T, Res).

class predicates
    amount : (strlist List, integer N [out]).
    amount : (strlist List, integer Crnt, integer N [out]).

clauses
    amount(List, N) :-
        amount(List, 0, N).

    amount([], Cur, Cur).

    amount([_ | T], Cur, N) :-
        amount(T, Cur + 1, N).

clauses
    run() :-
        file::consult("../data.txt", factsDB),
        fail.

    run() :-
        Ppl = [ Man || подписчик(_, Man, _, _) ], %Список с именами подписчиков
        List = [ Issue || издание(_, Issue, _, _) ], %Список с названиями газет
        write("Люди: "),
        print_list(Ppl),
        write("Газеты: "),
        print_list(List),
        amount(Ppl, N),
        write("Всего людей -", N, " \n"),
        amount(List, N1),
        write("Всего изданий -", N1, " \n"),
        P = [ Price || издание(_, _, _, Price) ],
        max_price(P, Max),
        write("Максимальная цена за экземпляр газеты: "),
        write(Max, "$\n"),
        min_price(P, Min),
        write("Минимальная цена за экземпляр газеты: "),
        write(Min, "$\n"),
        write("Введите ценовой диапазон за один выпуск газет: \n"),
        write("Введите минимальную цену($) за выпуск: \n"),
        MinPr = stdio::readLine(),
        write("Введите максимальную цену($) за выпуск: \n"),
        MaxPr = stdio::readLine(),
        L =
            [ Name ||
                издание(_, Name, _, Price),
                Price > toTerm(MinPr),
                Price < toTerm(MaxPr)
            ],
        write("Все газеты с ценой в  заданном диапазоне: \n"),
        print_list(L),
        write("Введите имя человека, которого нужно найти среди подписчиков: "),
        Nm = stdio::readLine(),
        find_man(Nm, Ppl, Res),
        find_man_interface(Res),
        write("Введите имя человека, для которого нужно подсчитать сумму месячных подписок: "),
        Name = stdio::readLine(),
        Person =
            [ Cost ||
                подписчик(ID, Name, _, _),
                подписался(_, ID, _, Cost)
            ],
        subscriptions_per_month_sum(Person, Cost),
        write(Cost, "$"),
        write("\n !------- Далее -- функционал из Лабораторной работы №2 --------! \n"),
        write("Введите название газеты, чтобы узнать ее подписчиков:\n"),
        Title = stdio::readLine(),
        subscribers_of(Title),
        write("Введите название газеты, чтобы узнать ее цену:\n"),
        T = stdio::readLine(),
        price(T),
        write("Введите имя человека, чтобы узнать на что он подписан:\n"),
        Nn = stdio::readLine(),
        name_subscribed_on(Nn),
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
