#!/bin/sh
cd `dirname $0`

echo Starting Nitrogen.
erl \
    -name nitrogen@localhost \
    -pa ./ebin -pa ./include \
    -s make all \
    -eval "application:start(user_login)" \
    -eval "application:load(esmtp)" \
    -eval "application:start(esmtp)" \
    -eval "db_utils:start()" \
    
#-config "/Users/tjweir/g/homebrew/Cellar/erlang/R13B03/lib/erlang/releases/R13B03/start.script"
