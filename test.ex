defmodule Test do
    def double(n) do
        n * 2
    end

    def muricaHeatToNormal(f) do
        (f - 32) / 1.8
    end

    def product(m, n) do
        case m do
        0 ->
            0

        _ ->
            n + product(m - 1, n)
        end
    end

    def exp(x, n) do
        case n do
        0 ->
            1

        _ ->
            product(exp(x, n - 1), x)
        end
    end

  # ====================================================== #
  # =================== INSERTION SORT =================== #
  # ====================================================== #

    def isort(l) do
        isort(l, [])
    end

    def isort(x, l) do
        case l do
        [] ->
            [h, t] = x
            x = t
            l ++ h
            isort(x, l)
        [h | t] when h < x ->
            # ideas pls

        [h | t] ->
            # nothing here, yet :>

        end
    end

    def insert(e, l) do
        case l do
            [h | _] when e < h ->
                [e | l]

            [h | t] ->
                [h | insert(e, t)]
        end
    end

end
