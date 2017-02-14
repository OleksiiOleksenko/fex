#!/usr/bin/env bash

cd $COMP_BENCH

echo "Phoenix"
./fex.py run -n phoenix_perf -t gcc_native gcc_asan --multithreaded_build -i test

echo ""
echo "Parsec"
./fex.py run -n parsec_perf -t gcc_native gcc_asan --multithreaded_build -i test

cd -
