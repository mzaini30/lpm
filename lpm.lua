#!/bin/lua

local function trim(teks)
  return teks:gsub("^%s*(.-)%s*$", "%1")
end

local function split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

local function unik(data)
  local hash = {}
  local res = {}
  for _,v in ipairs(data) do
    if (not hash[v]) then
      res[#res+1] = v -- you could print here instead of saving to result table if you wanted
      hash[v] = true
    end
  end
  return res
end

local function is_rockspec()
  local manifest = io.popen("ls *.rockspec")
  if manifest then
    manifest = manifest:read("*a")
    manifest = trim(manifest)
    if #manifest > 0 then
      return true
    else
      return false
    end
  end
end

local function olah_rockspec(datanya)
  local manifest = io.popen("ls *.rockspec")
  if manifest then
    manifest = manifest:read("*a")
    manifest = trim(manifest)
    local baca = io.open(manifest, "r")
    if baca then
      baca = baca:read("*a")

      baca_duplikat = baca
      baca_duplikat = baca_duplikat:gsub("[%s%S]+dependencies = {", ""):gsub("}", "")
      baca_duplikat = trim(baca_duplikat)
      local paket = split(baca_duplikat, "\n")
      for n, x in ipairs(paket) do
        paket[n] = trim(x):gsub("\"", ""):gsub(",", "")
      end
      for n, x in ipairs(datanya) do
        table.insert(paket, x)
      end
      paket = unik(paket)
      local dependencies = "dependencies = {\n"
      for n, x in ipairs(paket) do
        dependencies = dependencies .. "    \"" .. x .. "\",\n"
      end
      dependencies = dependencies:sub(0, -3) .. "\n"
      dependencies = dependencies .. "}"

      baca = baca:gsub("[^_]dependencies = {[%s%S]+}", "") .. "\n" .. dependencies
      local ubah_manifest = io.open(manifest, "w")
      if ubah_manifest then
        ubah_manifest:write(baca)
      end
    end
  end
end

local function init()
  local cek_dulu = is_rockspec()
  if not cek_dulu then
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
    url = 'https://github.com/yourname/]]..folder..[[/archive/v0.0-1.tar.gz'
}
test = {
}
test_dependencies = {
}
build = {
    type = 'none'
}
-- dependencies must be at the bottom
dependencies = {
}]])
      end
    end
  end
end

if arg[1] == "i" then
  local cek_dulu = is_rockspec()
  if not cek_dulu then
    init()
  end
  -- install dari rockspec dulu
  local popen_rockspec = io.popen("ls *.rockspec")
  if popen_rockspec then
    local rockspec = popen_rockspec:read("*a")
    rockspec = trim(rockspec) -- nama file rockspec-nya
    -- os.execute("luarocks install --tree lua_modules \"" .. rockspec .. "\" --only-deps")
    os.execute("luarocks --local install \"" .. rockspec .. "\" --only-deps")

    if arg[2] then -- contoh: lpm i a b c
      local paket_baru = {}
      for n, x in ipairs(arg) do
        if n > 1 then
          -- masukkan ke rockspec
          -- os.execute("luarocks install " .. x .. " --tree lua_modules")
          os.execute("luarocks --local install " .. x)
          table.insert(paket_baru, x)
        end
      end
      olah_rockspec(paket_baru)
    end
  end
end

if arg[1] == "init" then -- sudah
  init()
end

-- if arg[1] == "c" then -- sudah
--   os.execute("luarocks purge --tree lua_modules")
-- end
