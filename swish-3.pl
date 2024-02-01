% Represent a state as [CLeft, MLeft, B, CRight, MRight]
initial_state([3, 3, left, 0, 0]). % Beginning State
goal_state([0, 0, right, 3, 3]).    % Final State

legal_move(CLeft, MLeft, CRight, MRight) :-
    CLeft >= 0,
    MLeft >= 0,
    CRight >= 0,
    MRight >= 0,
    (MLeft >= CLeft ; MLeft = 0),
    (MRight >= CRight ; MRight = 0).

% Possible moves:
transition([CLeft, MLeft, left, CRight, MRight], [CLeft, MLeft2, right, CRight, MRight2]) :-
    % Two missionaries cross left to right.
    MRight2 is MRight + 2,
    MLeft2 is MLeft - 2,
    legal_move(CLeft, MLeft2, CRight, MRight2).

transition([CLeft, MLeft, left, CRight, MRight], [CLeft2, MLeft, right, CRight2, MRight]) :-
    % Two cannibals cross left to right.
    CRight2 is CRight + 2,
    CLeft2 is CLeft - 2,
    legal_move(CLeft2, MLeft, CRight2, MRight).

transition([CLeft, MLeft, left, CRight, MRight], [CLeft2, MLeft2, right, CRight2, MRight2]) :-
    % One missionary and one cannibal cross left to right.
    CRight2 is CRight + 1,
    CLeft2 is CLeft - 1,
    MRight2 is MRight + 1,
    MLeft2 is MLeft - 1,
    legal_move(CLeft2, MLeft2, CRight2, MRight2).

transition([CLeft, MLeft, left, CRight, MRight], [CLeft, MLeft2, right, CRight, MRight2]) :-
    % One missionary crosses left to right.
    MRight2 is MRight + 1,
    MLeft2 is MLeft - 1,
    legal_move(CLeft, MLeft2, CRight, MRight2).

transition([CLeft, MLeft, left, CRight, MRight], [CLeft2, MLeft, right, CRight2, MRight]) :-
    % One cannibal crosses left to right.
    CRight2 is CRight + 1,
    CLeft2 is CLeft - 1,
    legal_move(CLeft2, MLeft, CRight2, MRight).

transition([CLeft, MLeft, right, CRight, MRight], [CLeft, MLeft2, left, CRight, MRight2]) :-
    % Two missionaries cross right to left.
    MRight2 is MRight - 2,
    MLeft2 is MLeft + 2,
    legal_move(CLeft, MLeft2, CRight, MRight2).

transition([CLeft, MLeft, right, CRight, MRight], [CLeft2, MLeft, left, CRight2, MRight]) :-
    % Two cannibals cross right to left.
    CRight2 is CRight - 2,
    CLeft2 is CLeft + 2,
    legal_move(CLeft2, MLeft, CRight2, MRight).

transition([CLeft, MLeft, right, CRight, MRight], [CLeft2, MLeft2, left, CRight2, MRight2]) :-
    % One missionary and one cannibal cross right to left.
    CRight2 is CRight - 1,
    CLeft2 is CLeft + 1,
    MRight2 is MRight - 1,
    MLeft2 is MLeft + 1,
    legal_move(CLeft2, MLeft2, CRight2, MRight2).

transition([CLeft, MLeft, right, CRight, MRight], [CLeft, MLeft2, left, CRight, MRight2]) :-
    % One missionary crosses right to left.
    MRight2 is MRight - 1,
    MLeft2 is MLeft + 1,
    legal_move(CLeft, MLeft2, CRight, MRight2).

transition([CLeft, MLeft, right, CRight, MRight], [CLeft2, MLeft, left, CRight2, MRight]) :-
    % One cannibal crosses right to left.
    CRight2 is CRight - 1,
    CLeft2 is CLeft + 1,
    legal_move(CLeft2, MLeft, CRight2, MRight).

% Recursive call to solve the problem
path([CLeft1, MLeft1, B1, CRight1, MRight1], [CLeft2, MLeft2, B2, CRight2, MRight2], Explored, MovesList) :-
    transition([CLeft1, MLeft1, B1, CRight1, MRight1], [CLeft3, MLeft3, B3, CRight3, MRight3]),
    \+ member([CLeft3, MLeft3, B3, CRight3, MRight3], Explored),
    path([CLeft3, MLeft3, B3, CRight3, MRight3], [CLeft2, MLeft2, B2, CRight2, MRight2],
         [[CLeft3, MLeft3, B3, CRight3, MRight3] | Explored],
         [[[CLeft3, MLeft3, B3, CRight3, MRight3], [CLeft1, MLeft1, B1, CRight1, MRight1]] | MovesList]).

% Solution found
path([CLeft, MLeft, B, CRight, MRight], [CLeft, MLeft, B, CRight, MRight], _, MovesList) :-
    print_moves(MovesList).

% Printing
print_moves([]) :- nl.
print_moves([[A, B] | MovesList]) :-
    print_moves(MovesList),
    write(B), write(' -> '), write(A), nl.

% Find the solution for the missionaries and cannibals problem
solve_cannibals_missionaries :-
    path([3, 3, left, 0, 0], [0, 0, right, 3, 3], [[3, 3, left, 0, 0]], _),
    !.


% Run the program and display the solution
?- solve_cannibals_missionaries.
