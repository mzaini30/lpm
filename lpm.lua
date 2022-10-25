#!/bin/lua

package.path = package.path .. ";lua_modules/share/lua/5.1/?.lua"

function trim(teks)
  return teks:gsub("^%s*(.-)%s*$", "%1")
end

if arg[1] == "tes" then
  local manifest = io.popen("ls *.rockspec")
  if manifest then
    manifest = manifest:read("*a")
    manifest = trim(manifest)
    local baca = io.open(manifest, "r")
    if baca then
      baca = baca:read("*a")
      print(baca)
    end
  end
end

if arg[1] == "i" then
  -- install dari rockspec dulu
  local popen_rockspec = io.popen("ls *.rockspec")
  if popen_rockspec then
    local rockspec = popen_rockspec:read("*a")
    rockspec = trim(rockspec) -- nama file rockspec-nya
    os.execute("luarocks install --tree lua_modules \"" .. rockspec .. "\" --only-deps")

    if arg[2] then -- contoh: lpm i a b c
      for n, x in ipairs(arg) do
        if n > 1 then
          -- masukkan ke rockspec
          os.execute("luarocks install " .. x .. " --tree lua_modules")
        end
      end
    end
  end
end

if arg[1] == "init" then -- sudah
  local popen_folder = io.popen("basename $(pwd)")
  if popen_folder then
    local folder = popen_folder:read("*a")
    folder = folder:gsub("^%s*(.-)%s*$", "%1")
    local file = io.open(folder .. "-0.0-1.rockspec", "w")
    if file then
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
    end
  end
end

if arg[1] == "c" then -- sudah
  os.execute("luarocks purge --tree lua_modules")
end