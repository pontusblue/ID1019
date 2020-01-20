defmodule Queue do
  def new() do
    {:queue, [], []}
  end

  def add({:queue, back, front}, elem) do
    {:queue, [elem|back], front}
  end

  def remove({:queue, [], []}) do
    :fail
  end

  def remove({:queue, back, [elem | rest]}) do
    {:ok, elem, {:queue, back, rest}}
  end

  def remove({:queue, back, []}) do
    remove({:queue, [], Enum.reverse(back)})
  end
end


defmodule BinaryTree do
#####################################################
#                                                   #
# Structure of node types:                          #
#   {:leaf, value}                                  #
#   {:node, value, left, right}                     #
#                                                   #
# Example:                                          #
#   tree = {:node, 38, {:leaf, 42}, {:leaf, 34}}    #
#                                                   #
#####################################################

#
# Example tree:
#
# t = {:node, :k, 38,
#           {:node, :b, 34, :nil, :nil},
#           {:node, :o, 40, {:node, :l, 42, :nil, :nil},
#                           {:node, :q, 39, :nil, :nil}}}
#

# Find if element is member of a tree
def member(_, :nil) do :no end
def member(n, {:leaf, ...}) do :yes end
def member(_, {:leaf, ...}) do :no end

def member(n, {:node, ..., ..., ...}) do :yes end

# Unordered tree
def member(n, {:node, _, left, right}) do
    case ... do
        :yes -> :yes
        :no -> ...
    end
end

# Ordered tree
def member(n, {:node, v, left, right}) do
    if n < v do
        ...
    else
        ...
    end
end


end