REM ************************************
REM * date: 22.07.2014
REM * autor: Filip Ryborz
REM * website: simply-embedded.blogspot.com
REM *
REM * Script for build automation :
REM * 1. Compilation and linking using GNU GCC compiler
REM * 2. Generation of code coverage files with GCOV
REM * 3. Demangling files using C++filt 
REM * 4. Generation of HTML coverage reports using LCOV
REM *
REM * Prerequisites:
REM * g++, gcov, c++filt in PATH or add paths!
REM * Perl and association of files with .Perl extension
REM * Problems when associating using Windows dialogs! Instead use command line!
REM * command: assoc .perl=Perl.File
REM * command: ftype Perl.File=C:\Perl\bin\perl.exe "%1" %*
REM ************************************

REM change directory to build.bat directory and create folders needed for output data
cd %~dp0
md HTML
md Debug
md Debug\Drivers
md Debug\Logic
md Debug\info
md Debug\info\built
md Debug\info\built\Drivers
md Debug\info\built\Logic
md Debug\info\gcov
md Debug\info\gcov\Drivers
md Debug\info\gcov\Logic

REM compile source code
cd %~dp0\Drivers
for /R "%~dp0\Drivers" %%f in (*.cpp) do g++  -I../Drivers -I../Logic -O0 -g3 -p -pg -Wall -c -fpermissive -fmessage-length=0 -coverage -fno-access-control -o ../Debug/Drivers/%%~nf.o %%~nf.cpp 2> "%~dp0\Debug\info\built\Drivers\%%~nf.log"
cd %~dp0\Logic
for /R "%~dp0\Logic" %%f in (*.cpp) do g++ -I../Drivers -I../Logic -O0 -g3 -p -pg -Wall -c -fpermissive -fmessage-length=0 -coverage -fno-access-control -o ../Debug/Logic/%%~nf.o %%~nf.cpp 2> "%~dp0\Debug\info\built\Logic\%%~nf.log"

REM link files
cd %~dp0\Debug
g++ -coverage -g -p -pg -o CodeCoverage.exe Drivers/serialPort.o Logic/interfaceHandler.o Logic/main.o 2> "%~dp0\Debug\info\built\CodeCoverage.log"

REM execute program
cd %~dp0\Debug
%~dp0\Debug\CodeCoverage.exe > %~dp0\Debug\info\CodeCoverage.log

REM copying of source files needed for GCOV
copy %~dp0\Drivers\*.* %~dp0\Debug\Drivers
copy %~dp0\Logic\*.* %~dp0\Debug\Logic


REM demangle files and store copies - not needed, only an option to have the GCOV files
cd %~dp0\Debug\Drivers
for %%f in (%~dp0\Debug\Drivers\*.gcno) do (
gcov -f -b "%%~nf.gcno" | C++filt -n  > "%~dp0\Debug\info\gcov\Drivers\%%~nf.log"
c++filt -n < %%~nf.cpp.gcov > %%~nf.cpp.gcov1
c++filt -n < %%~nf.hpp.gcov > %%~nf.hpp.gcov1
)

REM demangle files and store copies - not needed, only an option to have the GCOV files
cd %~dp0\Debug\Logic
for %%f in (%~dp0\Debug\Logic\*.gcno) do (
gcov -f -b "%%~nf.gcno" | C++filt -n  > "%~dp0\Debug\info\gcov\Logic\%%~nf.log"
c++filt -n < %%~nf.cpp.gcov > %%~nf.cpp.gcov1
c++filt -n < %%~nf.hpp.gcov > %%~nf.hpp.gcov1
)

REM remove original GCOV files
cd %~dp0\Debug\Drivers
del *.cpp.gcov
del *.hpp.gcov

cd %~dp0\Debug\Logic
del *.cpp.gcov
del *.h.gcov

cd %~dp0\Debug
del *.cpp.gcov
del *.hpp.gcov

REM launch LCOV and GENHTML to get HTML coverage report
cd %~dp0
C:\Perl\bin\Perl.exe lcov.perl --capture --directory Debug --output-file debug/coverage.info --rc lcov_branch_coverage=1
C:\Perl\bin\Perl.exe genhtml.perl --output HTML debug/coverage.info --demangle-cpp --prefix %~dp0 --function-coverage --branch-coverage --show-details