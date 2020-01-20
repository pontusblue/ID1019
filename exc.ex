defmodule Deriv do
  #  2x^2 + 3x + 5 -> 

  def deriv({:const, _}, _) do
    0
  end

  def deriv({:var, v}, v) do
    1
  end

  def deriv({:var, y}, _) do
    0
  end

  def deriv({:mul, e1, e2}, v) do
    {:add, {:mul, deriv(e1, v), e2}, {:mul, deriv(e2, v), e1}}
  end

  def deriv({:add, e1, e2}, v) do
    {:add, deriv(e1, v), deriv(e2, v)}
  end

  def deriv({:exp, e1, e2}, v) do
    {:mult, deriv(e1, v), {:mult, e2, {:exp, e1, {:add, e2, {:const, -1}}}}}
  end

  def deriv({:ln, e}, v) do 
    {:mult, deriv(e, v), {:exp, e, {:const, -1}}}
  end

end
