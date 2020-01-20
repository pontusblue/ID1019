defmodule MergeSort do
    
    def msort(l) do
        case l do
            [] ->
                []
            [e] -> [e]
            _ ->
                {left, right} = msplit(l, [], [])
                merge(msort(left), msort(right))
        end
    end

    def merge([e], []) do [e] end
    def merge([e | r], []) do
        msort([e | r])
    end
    def merge([e1], [e2]) do
        cond do
            e1 < e2 -> [e1, e2]
            true -> [e2, e1]
        end
    end
    def merge([e1|t1], [e2|t2]) do
        if e1 < e2 do
            [e1 | merge([e2|t1], t2)]
        else 
            [e2 | merge([e1|t1], t2)]
        end
    end

    def msplit(l, p1, p2) do
        case l do
            [] -> 
                {p1, p2}
            [e1] ->
                {[e1|p1], p2}
            [e1, e2 | r] ->
                msplit(r, [e1|p1], [e2|p2])
        end
    end

end