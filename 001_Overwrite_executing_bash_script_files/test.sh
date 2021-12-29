#!/usr/bin/env bash

WORK_DIR=work
test -d $WORK_DIR || mkdir $WORK_DIR

function _setup() {
    cp ../test/01_test_script.sh .
    cp ../test/01_test_script_copy.sh .
    cp ../test/02_test_script.sh .
    cp ../test/02_test_script_copy.sh .
}

cd $WORK_DIR

_setup
echo ""
echo "================================"
echo "copy shell script test"
./01_test_script.sh &
TEST_PID=$!
sleep 2
cp 01_test_script_copy.sh 01_test_script.sh
wait $TEST_PID
echo ""
echo "### 01_test_script.sh"
cat 01_test_script.sh

_setup
echo ""
echo "================================"
echo "rsync shell script test"
./01_test_script.sh &
TEST_PID=$!
sleep 2
rsync 01_test_script_copy.sh 01_test_script.sh
wait $TEST_PID
echo ""
echo "### 01_test_script.sh"
cat 01_test_script.sh

_setup
echo ""
echo "================================"
echo "copy block shell script test"
./02_test_script.sh &
TEST_PID=$!
sleep 2
cp 02_test_script_copy.sh 02_test_script.sh
wait $TEST_PID
echo ""
echo "### 02_test_script.sh"
cat 02_test_script.sh

echo ""