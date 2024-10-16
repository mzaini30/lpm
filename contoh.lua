package = 'belajar-lua'
version = '0.0-1'
rockspec_format = '3.0'
source = {
    url = 'https://github.com/yourname/belajar-lua/archive/v0.0-1.tar.gz',
    dir = 'belajar-lua-0.0-1'
}
description = {
    summary = "Belajar Lua",
    homepage = "https://github.com/yourname/belajar-lua",
    license = "MIT",
    detailed = [[
        Belajar Lua
    ]],
}
-- test = {
-- }
-- test_dependencies = {
-- }
build = {
    type = 'builtin',
    modules = {
        ['belajar-lua'] = 'index.lua',
    },
}
-- dependencies must be at the bottom
dependencies = {
    "lua-input",
    "aghpb"
}