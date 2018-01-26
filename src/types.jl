mutable struct ChecklistItem{T}
    value::T
    button::GtkCheckButton
end

ChecklistItem(value) = ChecklistItem(value, GtkCheckButton(string(value), active = true))

isselected(item::ChecklistItem) = getproperty(item.button, "active", Bool)

mutable struct ChecklistColumn{T}
    name::Symbol
    button::GtkToggleButton
    items::Vector{ChecklistItem{T}}
end

ChecklistColumn(name::Symbol, values::AbstractVector{T}) where {T} =
    ChecklistColumn(name, GtkToggleButton(string(name)), ChecklistItem.(values))

selecteditems(col::ChecklistColumn) = [i.value for i in col.items if isselected(i)]

name(col::ChecklistColumn) = col.name

mutable struct PlotOptions
    name::Symbol
    button::GtkComboBoxText
    items::Vector{String}
end

function PlotOptions(name, values)
    cb = GtkComboBoxText()
    items = string.(values)
    for item in items
      push!(cb, item)
    end
    PlotOptions(name, cb, items)
end
