mkdir build
cd build

cmake ^
    -DCMAKE_INSTALL_PREFIX="%PREFIX%" ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    ..
if errorlevel 1 exit 1

cmake --build . --target ALL_BUILD --config Release --parallel %CPU_COUNT%
if errorlevel 1 exit 1

@REM only available in master branch for now, and only works for Debug config:
@REM cmake --build . --target RUN_TESTS
@REM if errorlevel 1 exit 1

cmake --build . --target INSTALL --config Release
if errorlevel 1 exit 1
