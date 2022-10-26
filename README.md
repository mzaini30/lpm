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

### Clean

```bash
lpm c
```

## TODO

- [x] modify rockspec file (using: luarocks --tree lua_modules/ list)
- [ ] lpm version
- [ ] lpm run
- [ ] lpm test
- [ ] lpm publish
- [ ] lpm init: kalau sudah ada file rockspec, cancel
- [ ] lpm i: kalau belum ada file rockspec, jalankan "lpm init" terlebih dahulu
- [ ] pas init, masukkan "url" sekalian
