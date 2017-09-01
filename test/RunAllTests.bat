@echo off
set errorlevel=
..\bin\Release\match-set.exe test_set_x.txt test_set_y.txt >nul
if errorlevel 887 (
  echo PASS
  exit /b 0
)
echo FAIL
exit /b 1
