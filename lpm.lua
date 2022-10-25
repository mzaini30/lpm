#!/bin/lua

if arg[1] == "i" then
end

if arg[1] == "init" then -- sudah
  local popen_folder = io.popen("basename $(pwd)")
  local folder = popen_folder:read("*a")
    folder = folder:gsub("^%s*(.-)%s*$", "%1")
    local file = io.open(folder .. "-0.0-1.rockspec", "w")
      file:write([[
package = ']] .. folder .. [['
version = '0.0-1'
rockspec_format = '3.0'
source = {
    url = ''
}
test = {
}
test_dependencies = {
}
dependencies = {
}
build = {
    type = 'none'
}
      ]])
    file:close()
  popen_folder:close()
end

if arg[1] == "c" then -- sudah
  os.execute("luarocks purge --tree lua_modules")
end