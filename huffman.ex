defmodule Huffman do
  def sample do
    #'the quick brown fox jumps over the lazy dog
    #this is a sample text that we will use when we build
    #up a table we will only handle lower case letters and
    #no punctuation symbols the frequency will of course not
    #represent english but it is probably not that far off'
    'pontus'
  end

  def text do
    'pontus'
  end

  def test() do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    # decode = decode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq, tree)

    #######
    #seq
    #encode

  end

  def tree(sample) do
    freq = freq(sample)
    huffman(Huffman_ISort.insertionSort(freq))
  end

  def freq(sample) do
    freq(sample, [])
  end

  def freq([], freq) do
    freq
  end

  def freq([char | rest], freq) do
    freq(rest, addFreq(char, freq))
  end

  def addFreq(char, freq) do
    case freq do
      [] -> [{char, 1}]
      [{c, n} | rest] when char == c -> [{c, n + 1} | rest]
      [head | rest] -> [head | addFreq(char, rest)]
    end
  end

  def huffman([{tree, size}]) do
    tree
  end

  def huffman([{c1, f1}, {c2, f2} | tail]) do
    huffman(Huffman_ISort.insert({{c1, c2}, f1 + f2}, tail))
  end

  def encode_table(tree) do
    encode_table(tree, [])
  end

  def encode_table({left, right}, path) do
    encode_table(left, [0 | path]) ++ encode_table(right, [1 | path])
  end

  def encode_table(leaf, path) do
    [{leaf, Enum.reverse(path)}]
  end

  def decode_table(tree) do
    # To implement...
  end

  def encode([], table) do [] end

  def encode([c|t], table) do
    get_code(c, table) ++ encode(t, table)
  end

  def get_code(_, []) do [-1] end
  def get_code(char, [head | tail]) do
    case head do
        {key, code} when char == key -> code
        {key, code} -> get_code(char, tail)
    end
  end

  def decode(seq, tree) do
    decode(seq, tree, tree)
  end

  def decode([], _, _) do [] end

  def decode([dir|path], position, tree) do
    case position do
      {left, _} when dir == 0 -> decode(path, left, tree)
      {_, right} when dir == 1 -> decode(path, right, tree)
      char -> [char | decode([dir|path], tree, tree)]
    end
  end

end

defmodule Huffman_ISort do
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
    {c1, f1} = e

    case l do
      [] -> [e]
      [{c2, f2} | t] when f1 <= f2 -> [e | l]
      [h | t] -> [h | insert(e, t)]
    end
  end
end
