#!/bin/lua

if arg[1] == "i" then
  -- install dari rockspec dulu
  local popen_rockspec = io.popen("ls *.rockspec")
    local rockspec = popen_rockspec:read("*a")
    rockspec = rockspec:gsub("^%s*(.-)%s*$", "%1") -- nama file rockspec-nya
    os.execute("luarocks install --tree lua_modules \"" .. rockspec .. "\" --only-deps")

    if arg[2] then -- contoh: lpm i a b c
      for n, x in ipairs(arg) do
        if n > 1 then
          -- masukkan ke rockspec
          os.execute("luarocks install " .. x .. " --tree lua_modules")
        end
      end
    end

  popen_rockspec:close()
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