% pex5.pl
% USAFA UFO Sightings 2024
%
% name: Brandon Son
%
% Documentation: I used the provided HW07_PROLOG to help with structure and reasoning through a problem. 
% No other outside resources used on this assignment.
%

% The query to get the answer(s) or that there is no answer
% ?- solve.


% facts
cadet(smith).
cadet(garcia).
cadet(jones).
cadet(chen).

day(tue).
day(wed).
day(thu).
day(fri).

object(weather_balloon).
object(kite).
object(fighter_aircraft).
object(cloud).

% Main Solver
solve :-
    % assign a day and an object to each cadet
    day(SmithDay), day(GarciaDay), day(JonesDay), day(ChenDay),
    all_different([SmithDay, GarciaDay, JonesDay, ChenDay]),

    object(SmithObj), object(GarciaObj), object(JonesObj), object(ChenObj),
    all_different([SmithObj, GarciaObj, JonesObj, ChenObj]),

    Triples = [
        [smith, SmithDay, SmithObj],
        [garcia, GarciaDay, GarciaObj],
        [jones, JonesDay, JonesObj],
        [chen, ChenDay, ChenObj]
    ],

    % clues

    % C4C Smith did not see a weather balloon, nor kite
    \+ member([smith, _, weather_balloon], Triples),
    \+ member([smith, _, kite], Triples),

    % Cadet who saw the kite is not C4C Garcia
    \+ member([garcia, _, kite], Triples),

    % Friday sighting was made by either C4C Chen or the one who saw the fighter aircraft
    member([FriCadet, fri, _], Triples),
    ( FriCadet = chen
    ; member([FriCadet, _, fighter_aircraft], Triples)
    ),

    % The kite was not sighted on Tuesday
    \+ member([_, tue, kite], Triples),

    % Neither C4C Garcia nor C4C Jones saw the weather balloon
    \+ member([garcia, _, weather_balloon], Triples),
    \+ member([jones, _, weather_balloon], Triples),

    % C4C Jones did not make their sighting on Tuesday
    \+ member([jones, tue, _], Triples),

    % C4C Smith saw an object that turned out to be a cloud
    member([smith, _, cloud], Triples),

    % The figher aircraft was spotted on Friday
    member([_, fri, fighter_aircraft], Triples),

    % The weather balloon was not spotted on Wednesday
    \+ member([_, wed, weather_balloon], Triples),

    report_by_day(Triples).

report_by_day(Triples) :-
    member([WhoTue, tue, WhatTue], Triples),
    tell(tue, WhoTue, WhatTue),
    member([WhoWed, wed, WhatWed], Triples),
    tell(wed, WhoWed, WhatWed),
    member([WhoThu, thu, WhatThu], Triples),
    tell(thu, WhoThu, WhatThu),
    member([WhoFri, fri, WhatFri], Triples),
    tell(fri, WhoFri, WhatFri).

tell(Day, Cadet, Object) :-
    write(Day), write(': '),
    write(Cadet), write(' saw '),
    write(Object), write('.'), nl.

all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).
