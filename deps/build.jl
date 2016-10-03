using BinDeps

@BinDeps.setup

llea = library_dependency("libllea")

provides(Sources, URI("https://github.com/KosmosML/LLEA/archive/master.zip"), llea, os=:Unix, unpacked_dir="LLEA-master")

src = joinpath(BinDeps.depsdir(llea), "src", "LLEA-master")
prefix = joinpath(BinDeps.depsdir(llea), "usr")
build = joinpath(BinDeps.depsdir(llea), "build")

provides(SimpleBuild, (@build_steps begin
    GetSources(llea)
    CreateDirectory(build)
    @build_steps begin
        ChangeDirectory(build)
        `cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$prefix $src`
        `cmake --build .`
        `cmake --build . --target install`
    end
end), llea, os=:Unix)


@BinDeps.install Dict(:libllea => :libllea)
