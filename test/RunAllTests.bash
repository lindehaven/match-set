#!/usr/bin/env bash

# :: Calculate the start timestamp
start=$(date +%s.%N)

# :: Beginning of test suite
passed=0
script="../bin/Release/match-set.exe"

testcase="Match set y in x"
expected=$((887%256))
$script test_set_x.txt test_set_y.txt >/dev/null
result=$?
if [ $result != $expected ]; then echo error: Failure in $testcase: Expected $expected but was $result; exit 1; fi
((passed++))

testcase="Match set x in y"
expected=$((10%256))
$script test_set_y.txt test_set_x.txt >/dev/null
result=$?
if [ $result != $expected ]; then echo error: Failure in $testcase: Expected $expected but was $result; exit 1; fi
((passed++))

testcase="Match set x in x"
expected=$((12170%256))
$script test_set_x.txt test_set_x.txt >/dev/null
result=$?
if [ $result != $expected ]; then echo error: Failure in $testcase: Expected $expected but was $result; exit 1; fi
((passed++))

testcase="Match set y in y"
expected=$((20%256))
$script test_set_y.txt test_set_y.txt >/dev/null
result=$?
if [ $result != $expected ]; then echo error: Failure in $testcase: Expected $expected but was $result; exit 1; fi
((passed++))
# :: End of test suite

# :: Calculate the test execution time
end=$(date +%s.%N)    
duration=`echo "$start" "$end" | awk '{printf "%f\n", $2-$1}'`
hh=`echo "$duration" | awk '{printf "%d\n", $1/3600}'`
mm=`echo "$duration" | awk '{printf "%02d\n", $1/60%60}'`
ss=`echo "$duration" | awk '{printf "%02d\n", $1%60%60}'`
ms=`echo "$duration" | awk '{printf "%02d\n", ($1+0.005)*100%100}'`

# :: Successful test suite execution
echo Success: $passed tests passed.
echo Test time: $hh:$mm:$ss.$ms

exit 0
