defmodule Chopstick do
    def start do
        spawn_link(fn -> available() end)
    end

    def available() do
        receive do
            {:request, from} ->
                send(from, :approve)
                gone()
            :quit -> :ok
        end
    end

    def gone() do
        receive do
            {:return, from} ->
                send(from, :returned)
                available()
            :quit -> :ok
        end
    end

    def request(stick, timeout) do
        send(stick, {:request, self()})
        receive do
            :approve -> :granted
            :quit -> :ok
        after timeout ->
            :deny
        end
    end

    def return(stick) do
        send(stick, {:return, self()})
        receive do
            :quit -> :ok
            :returned -> :nomorefood
        end
    end

    def quit(stick) do
        send(stick, :quit)
        receive do
            :ok -> :ez
        end
    end
end