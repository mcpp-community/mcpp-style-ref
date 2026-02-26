-- gcc 15.1
set_languages("c++23")

target("mcpp-style-ref")
    set_kind("binary")
    add_files("main.cpp")
    add_files("**.cppm")
    set_policy("build.c++.modules", true)

target("error")
    set_kind("static")
    add_files("error.cppm")
    add_files("error.cpp")