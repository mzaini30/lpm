#!/bin/bash

CMD=$1
shift

DEPFILE=deps-dev-0.rockspec

case $CMD in
  r | run)
    (eval $(luarocks path --bin --tree lua_modules); "$@")
    ;;

  t | test)
    luarocks test --tree lua_modules
    ;;

  i | install)
    luarocks install --tree lua_modules "$@"
    ;;

  id | install_deps)
    luarocks install --tree lua_modules "$DEPFILE" --only-deps
    ;;

  c | clean)
    luarocks purge --tree lua_modules
    ;;

  w | write_depfile)
    cat >$DEPFILE <<EOL
package = 'deps'
version = 'dev-0'
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
EOL
    echo "Wrote empty depfile to $DEPFILE"
    ;;

  *)
    echo "Unknown command $CMD"
    echo ""
    echo "lrt v1.4e-0"
    echo ""
    echo "usage: lrt <cmd> [options]"
    echo ""
    echo "install:             lrt i/install <rock name or rockspec> [additional luarocks arguments]"
    echo "install deps:        lrt id/install_deps"
    echo "run:                 lrt r/run <command name> [arguments]"
    echo "test:                lrt t/test"
    echo "clean:               lrt c/clean"
    echo "write empty depfile: lrt w/write_depfile/init"
    exit 1
    ;;
esac
