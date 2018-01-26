module GroupedErrorsGtk

using Gtk, JuliaDB, GroupedErrors, StatPlots

gr(size = (210, 140), grid = false)

include("types.jl")
include("buildwindow.jl")
include("selectdata.jl")
include("plot.jl")

end
