# lpm

Lua version `npm`.

## Installation

```bash
luarocks install lpm
```

## Using

### Init

```bash
lpm init
```

### Install from Rockspec

```bash
lpm i
```

### Install New Packages

```bash
lpm i package1 package2 package3
```

## TODO

- [x] modify rockspec file (using: luarocks --tree lua_modules/ list)
- [ ] lpm version
- [ ] lpm run
- [ ] lpm test
- [ ] lpm publish
- [x] lpm init: kalau sudah ada file rockspec, cancel
- [x] lpm i: kalau belum ada file rockspec, jalankan "lpm init" terlebih dahulu
- [x] pas init, masukkan "url" sekalian
- [x] install in global
