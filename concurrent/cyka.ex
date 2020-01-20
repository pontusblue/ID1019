defmodule Cyka do

    def talk(to, msg) do
        send(to, msg)
    end
    
end