defmodule Env do
  def new() do
    []
  end

  def add(id, str, []) do
    {id, str}
  end

  def add(id, str, env) do
    case env do
      [{eid, _} | rest] when eid == id -> [{id, str} | rest]
      [binding | rest] -> [binding | add(id, str, rest)]
    end
  end

  def lookup(_, []) do
    nil
  end

  def lookup(id, env) do
    case env do
      [{eid, data} | _] when eid == id -> {eid, data}
      [_ | rest] -> lookup(id, rest)
    end
  end

  def remove([], env) do
    env
  end

  def remove(_, []) do
    []
  end

  def remove(ids, env) do
    [head | _] = [{hid, _} | tail] = env

    case Enum.member?(ids, hid) do
      true -> remove(ids, tail)
      false -> [head | remove(ids, tail)]
    end
  end
end

defmodule Eager do
  def eval_expr({:atm, id}, _) do
    {:ok, id}
  end

  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil ->
        :error

      {_, str} ->
        {:ok, str}
    end
  end


  def eval_expr({:cons, head, tail}, env) do
    case eval_expr(head, env) do
      :error ->
       :error

      {:ok, str} ->
        case eval_expr(tail, env) do
          :error ->
            :error

          {:ok, ts} ->
            {:ok, [str | ts]}
        end
    end
  end

  def eval_match(:ignore, _, env) do
    {:ok, env}
  end

  def eval_match({:atm, id}, id, env) do
    {:ok, env}
  end


  def eval_match({:var, id}, str, env) do
    case Env.lookup({:var, id}, env) do
      nil -> {:ok, Env.add(id, str, env)}
      {_, ^str} -> {:ok, env}
      {_, _} -> :fail
    end
  end

    def eval_match({:cons, hp1, tp1}, {:cons, hp2, tp2}, env) do
        case eval_match(hp1, tp1, env) do
            :fail -> :fail
            {:ok, env2} -> eval_match(hp2, tp2, env2)
        end
    end

    def eval_match(_, _, _) do
        :fail
    end

end
