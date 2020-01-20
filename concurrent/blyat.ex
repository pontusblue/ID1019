defmodule Blyat do
    
    def talk() do
        receive do
            value ->
               IO.puts "#{value} blyat"
        end
        
    end

end