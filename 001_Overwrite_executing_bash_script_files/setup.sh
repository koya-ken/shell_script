#!/bin/bash

target_dir=setup
test -d $target_dir || mkdir $target_dir

pushd $target_dir
# https://unix.stackexchange.com/questions/121013/how-does-linux-deal-with-shell-scripts#121025
{
    echo '#!/usr/bin/bash';
    for i in {1..10000}; 
    do printf "%s\n" "echo \"$i\"";
    done ;
} > ascript_without_block.bash;
chmod +x ascript_without_block.bash

{
    echo '#!/usr/bin/bash';
    echo '{'
    for i in {1..10000}; 
    do printf "%s\n" "echo \"$i\"";
    done ;
    echo 'exit'
    echo '}'
} > ascript_with_block.bash;
chmod +x ascript_with_block.bash

strace -s 2000 -o strace_ascript_without_block.log ./ascript_without_block.bash >/dev/null
strace -s 2000 -o strace_ascript_with_block.log ./ascript_with_block.bash >/dev/null