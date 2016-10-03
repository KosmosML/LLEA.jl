module LLEA

using Compat

const DEPS = joinpath(@__DIR__, "..", "deps", "deps.jl")
if isfile(DEPS)
    include(DEPS)
else
    error("libllea was not found. Please run 'Pkg.build(\"LLEA\").")
end

function init()
    code = ccall((:init_llea_c, libllea), Cint, ())
end

end # module
