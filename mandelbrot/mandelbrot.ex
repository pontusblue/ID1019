defmodule Brot do
  def mandelbrot(c, m) do
    z0 = Cmplx.new(0, 0)
    i = 0
    test(i, z0, c, m)
  end

  def test(i, _, _, i) do
    0
  end

  def test(i, z, c, m) do
    if Cmplx.absr(z) > 2 do
      i
    else
      test(i + 1, Cmplx.add(Cmplx.sqr(z), c), c, m)
    end
  end

  def rows(width, height, trans, depth, []) do
    rows(width, height, trans, depth, [], 1, 1)
  end

  def rows(width, height, trans, max, _, x, height) do
    [row(width, trans, max, [], x, height)]
  end
  def rows(width, height, trans, max, image, x, y) do
    [row(width, trans, max, [], x, y) | rows(width, height, trans, max, image, x, y + 1)]
  end

  def row(width, trans, max, _, width, y) do
    [Color.convert(mandelbrot(trans.(width, y), max), max)]
  end
  def row(width, trans, max, row, x, y) do
    [Color.convert(mandelbrot(trans.(x, y), max), max) | row(width, trans, max, row, x + 1, y)]
  end


  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn w, h ->
      Cmplx.new(x + k * (w - 1), y - k * (h - 1))
    end

    rows(width, height, trans, depth, [])
  end

  def demo() do
    small(-2.6, 1.2, 1.2)
  end

  def small(x0, y0, xn) do
    width = 960
    height = 540
    depth = 64
    k = (xn - x0) / width
    image = Brot.mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("small.ppm", image)
  end
end

defmodule Color do
  def convert(depth, max) do
    ratio = 1 - depth / max
    r = Kernel.trunc(255 * ratio)
    g = Kernel.trunc(255 * ratio)
    b = Kernel.trunc(255 * ratio)
    {:rbg, r, g, b}
  end
end

defmodule Cmplx do
  def new(r, i) do
    {r, i}
  end

  def add({ar, ai}, {br, bi}) do
    {ar + br, ai + bi}
  end

  def sqr({r, i}) do
    {r * r - i * i, 2 * r * i}
  end

  def absr({r, i}) do
    :math.sqrt(r * r + i * i)
  end
end
