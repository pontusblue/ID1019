defmodule Exam19 do

######## double even ########
    def evenx2([]) do [] end
    def evenx2([h|t]) do
        case rem(h, 2) do
            0 -> [h * 2 | evenx2(t)]
            1 -> [h     | evenx2(t)]
        end
    end

###### tree sum ########
    def treeSum(nil) do 0 end
    def treeSum({:node, val, left, right}) do
        val + treeSum(left) + treeSum(right)
    end

####### mirror ########
    def mirrorTree(nil) do nil end
    def mirrorTree({:node, val, left, right}) do
        {:node, val, mirrorTree(right), mirrorTree(left)}
    end

####### add #########
    def add(nil, num) do
        {:node, num, nil, nil}
    end
    def add({:node, val, left, right}, num) do
        cond do
            val > num -> {:node, val, add(right, num), left}
            true -> {:node, num, add(right, val), left}
        end
    end

######## fizzbuzz ##########
    def fizzbuzz(n) do
        fizzbuzz(1, n + 1, 1, 1)
    end
    def fizzbuzz(1, n, 1, 1) do
        fizzbuzz(1, n, 3, 5)
    end
    def fizzbuzz(final, final, _, _) do
        []
    end
    def fizzbuzz(fizzbuzz, final, fizzbuzz, fizzbuzz) do
        [:fizzbuzz | fizzbuzz(fizzbuzz + 1, final, fizzbuzz + 3, fizzbuzz + 5)]
    end
    def fizzbuzz(fizz, final, fizz, buzz) do
        [:fizz | fizzbuzz(fizz + 1, final, fizz + 3, buzz)]
    end
    def fizzbuzz(buzz, final, fizz, buzz) do
        [:buzz | fizzbuzz(buzz + 1, final, fizz, buzz + 5)]
    end
    def fizzbuzz(num, final, fizz, buzz) do
        [num | fizzbuzz(num + 1, final, fizz, buzz)]
    end

    def fizz(n) do
        fizz(1, n + 1, 1, 1)
    end
    def fizz(final, final, _, _) do
        []
    end
    def fizz(num, final, 3, 5) do
        [:fizzbuzz | fizz(num + 1, final, 1, 1)]
    end
    def fizz(num, final, fizz, 5) do
        [:buzz | fizz(num + 1, final, fizz + 1, 1)]
    end
    def fizz(num, final, 3, buzz) do
        [:fizz | fizz(num + 1, final, 1, buzz + 1)]
    end
    def fizz(num, final, fizz, buzz) do
        [num | fizz(num + 1, final, fizz + 1, buzz + 1)]
    end

###### Lambda Calculus #######

# (λx -> x + 5)4 = 9
# (λx -> (λy -> x + 2 * y)3)5 = (λx -> x + 6)5 = 11
# (λx -> (x)5)(λz -> z + z) = (λz -> z + z)5 = 10

###### Operational Semantics #######

###### Reduce a tree #######

    #def reduce(nil, acc, op) do acc end
    #def reduce({:node, val, left, right}, acc, op) do
    #    {:node, val, left, reduce(right, a)}
    #end


##### Parallel sum #######

    def sump({:leaf, val}), do: val
    def sump({:tree, left, right}) do
        pid = self()
        spawn(fn() -> send(pid, sump(left)) end)
        spawn(fn() -> send(pid, sump(right)) end)
        receive do sum1 ->
        receive do sum2 -> sum1 + sum2
        end end
    end
end
