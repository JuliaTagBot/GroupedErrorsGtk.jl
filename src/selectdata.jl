function selectdata(df, cs)
    names = map(name, cs)
    values = map(selecteditems, cs)
    f = i -> all(getfield(i, n) in v for (n, v) in zip(names, values))
    filter(f, df)
end
