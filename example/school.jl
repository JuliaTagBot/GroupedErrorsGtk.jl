using GroupedErrorsGtk

df = JuliaDB.loadtable(joinpath(@__DIR__, "school.csv"))
nbox = 5

buildwindow(df)

GroupedErrorsGtk.name(ChecklistColumn(:test, [1,2,3]))
unique_iter = ((key, union(column(df, key))) for key in colnames(df))
cols = Tuple(ChecklistColumn(key, sort(val)) for (key, val) in unique_iter
    if length(val) < nbox)
cols[2].
selectdata(df, cols)
GtkImage("/home/pietro/test.png")
