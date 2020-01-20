defmodule Exam do

    ######### 2.3 ##########
    def eval([n, '+' | expr]),  do: n + eval(expr)
    def eval([n, '-' | expr]),  do: n - eval(expr)
    def eval([n]),              do: n
    
    ######### 2.4 ##########
    def isomorfic(nil, nil), do: true
    def isomorfic(nil, _), do: false
    def isomorfic(_, nil), do: false
    def isomorfic({:tree, _, ll, lr}, {:tree, _, rl, rr}) do
        isomorfic(ll, rl) && isomorfic(lr, rr)
    end

end