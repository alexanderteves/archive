-module(ggt).
-export([calc/2]).
calc(A, 0) -> A;
calc(A, B) -> calc(B, A rem B).
