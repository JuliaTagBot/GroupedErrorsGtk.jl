function doplot(df, cs, x, y, tmp)
    seldata = selectdata(df, cs)
    plt = @> seldata begin
        @x getfield(_, x)
        @y getfield(_, y)
        @plot scatter(size = (210, 140), grid = false)
    end
    savefig(plt, tmp)
end
