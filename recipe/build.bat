mkdir build
cd build

cmake %CMAKE_ARGS% ^
    -G "NMake Makefiles" ^
    -DCMAKE_POSITION_INDEPENDENT_CODE=1 ^
    ..
if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1

cmake --build . --target check --config Release
if errorlevel 1 exit 1

cmake --build . --target INSTALL --config Release
if errorlevel 1 exit 1
