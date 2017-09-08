@echo off

:: Calculate the start timestamp
set _time=%time%
set /a _hours=100%_time:~0,1%%%100,_min=100%_time:~3,2%%%100,_sec=100%_time:~6,2%%%100,_cs=%_time:~9,2%
set /a _started=_hours*60*60*100+_min*60*100+_sec*100+_cs

:: Beginning of test suite
set passed=0
set script=..\bin\Release\match-set.exe

set testcase="Match set y in x"
set expected=887
%script% test_set_x.txt test_set_y.txt >nul
if not "%errorlevel%" == "%expected%" ( echo error: Failure in %testcase%: Expected %expected% but was %errorlevel% & exit /b 1 )
set /a passed=passed+1

set testcase="Match set x in y"
set expected=10
%script% test_set_y.txt test_set_x.txt >nul
if not "%errorlevel%" == "%expected%" ( echo error: Failure in %testcase%: Expected %expected% but was %errorlevel% & exit /b 1 )
set /a passed=passed+1

set testcase="Match set x in x"
set expected=12170
%script% test_set_x.txt test_set_x.txt >nul
if not "%errorlevel%" == "%expected%" ( echo error: Failure in %testcase%: Expected %expected% but was %errorlevel% & exit /b 1 )
set /a passed=passed+1

set testcase="Match set y in y"
set expected=20
%script% test_set_y.txt test_set_y.txt >nul
if not "%errorlevel%" == "%expected%" ( echo error: Failure in %testcase%: Expected %expected% but was %errorlevel% & exit /b 1 )
set /a passed=passed+1
:: End of test suite

:: Calculate the test execution time
set _time=%time%
set /a _hours=100%_time:~0,1%%%100,_min=100%_time:~3,2%%%100,_sec=100%_time:~6,2%%%100,_cs=%_time:~9,2%
set /a _duration=_hours*60*60*100+_min*60*100+_sec*100+_cs-_started
set /a _hours=_duration/60/60/100,_min=100+_duration/60/100%%60,_sec=100+(_duration/100%%60%%60),_cs=100+_duration%%100

:: Successful test suite execution
echo Success: %passed% tests passed.
echo Test time: %_hours%:%_min:~-2%:%_sec:~-2%.%_cs:~-2%
exit /b 0
