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

  def remove(x, []) do
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

  def unique(l) do
    [h | t] = l
    [h | unique(remove(h, t))]
  end

  def pack(l) do
  end

  def reverse(l) do
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
        [h, _] = x

      [h | t] when h < x ->
        0

      [h | t] ->
        0
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
