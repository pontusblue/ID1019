defmodule HTTP do
  def parse_request(r0) do
    {request, r1} = request_line(r0)
    {headers, r2} = headers(r1)
    {body, _} = message_body(r2)
    {request, headers, body}
  end

  def request_line([?G, ?E, ?T, 32 | r0]) do
    {uri, r1} = request_uri(r0)
    {ver, r2} = http_version(r1)
    [13, 10 | r3] = r2
    {{:get, uri, ver}, r3}
  end

  def request_uri([32 | r0]), do: {[], r0}

  def request_uri([c | r0]) do
    {rest, r1} = request_uri(r0)
    {[c | rest], r1}
  end

  def http_version([?H, ?T, ?T, ?P, ?/, ?1, ?., v | r0]) do
    case v do
      ?1 -> {:v11, r0}
      ?0 -> {:v10, r0}
    end
  end

  def headers([13, 10 | r0]), do: {[], r0}

  def headers(r0) do
    {header, r1} = header(r0)
    {rest, r2} = headers(r1)
    {[header | rest], r2}
  end

  def header([13, 10 | r0]), do: {[], r0}

  def header([c | r0]) do
    {rest, r1} = header(r0)
    {[c | rest], r1}
  end

  def message_body(r), do: {r, []}

  def ok(body), do: "HTTP/1.1 200 OK\r\n\r\n#{body}"

  def get(uri), do: "GET #{uri} HTTP/1.1\r\n\r\n"
end

###############################################|
#################            ##################|
########             RUDY             |########|
#################            ##################|
###############################################|

defmodule Rudy do
  def init(port) do
    opt = [:list, active: false, reuseaddr: true]

    case :gen_tcp.listen(port, opt) do
      {:ok, listen} ->
        ##############################...
        :gen_tcp.close(listen)
        :ok

      {:error, error} ->
        error
    end
  end

  def handler(listen) do
    case :gen_tcp.accept(listen) do
      {:ok, client} ->
        ##############################...
        42
      {:error, error} ->
        error
    end
  end

  def request(client) do
    recv = :gen_tcp.recv(client, 0)

    case recv do
      {:ok, str} ->
        ##############################...
        ##############################...
        :gen_tcp.send(client, response)

      {:error, error} ->
        IO.puts("RUDY ERROR: #{error}")
    end

    :gen_tcp.close(client)
  end

  def reply({{:get, uri, _}, _, _}) do
    HTTP.ok("Hello!")
  end
end
