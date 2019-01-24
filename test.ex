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
  # ============== SIMPLE FUNCTIONS ON LIST ============== #
  # ====================================================== #

  def len(l) do
    case l do
      [] -> 0
      [_ | x] -> 1 + len(x)
    end
  end

  def sum([]) do
    0
  end

  def sum(l) do
    [h | x] = l
    h + sum(x)
  end

  def duplicate(l) do
    case l do
      [] -> []
      [h | x] -> [h | [h | duplicate(x)]]
    end
  end

  def add(x, []) do
    [x]
  end

  def add(x, l) do
    [h | t] = l

    if x == h do
      l
    else
      [h | add(x, t)]
    end
  end

  def remove(_, []) do
    []
  end

  def remove(x, l) do
    case l do
      [h | t] when x == h ->
        remove(x, t)

      [h | t] ->
        [h | remove(x, t)]
    end
  end

  def unique([]) do
    []
  end

  def unique([h | t]) do
    [h | unique(remove(h, t))]
  end

  # Helper for pack
  def count(_, []) do
    0
  end

  def count(x, l) do
    case l do
      [h | t] when x == h ->
        1 + count(x, t)

      [_ | t] ->
        count(x, t)
    end
  end

  # Helper for pack
  def putMultiple(_, _, 0) do
    []
  end

  def putMultiple(e, l, x) do
    [e | putMultiple(e, l, x - 1)]
  end

  def pack([]) do
    []
  end

  def pack([h | t]) do
    [putMultiple(h, [], count(h, [h | t])) | pack(remove(h, t))]
  end

  def reverse([]) do
    []
  end

  def reverse([h | t]) do
    reverse(t) ++ [h]
  end

  # ====================================================== #
  # =================== INSERTION SORT =================== #
  # ====================================================== #

  def insertionSort(l) do
    insertionSort(l, [])
  end

  def insertionSort([], s) do
    s
  end

  def insertionSort([h | t], s) do
    insertionSort(t, insert(h, s))
  end

  def insert(e, l) do
    case l do
      [] -> [e]
      [h | t] when e < h -> [e | l]
      [h | t] -> [h | insert(e, t)]
    end
  end

  def fib(n) do

  end

  def fib(n1, n2) do
    
  end
end
