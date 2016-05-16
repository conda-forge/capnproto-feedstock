mkdir build
cd build

:: CAPNP_LITE=ON is required since Cap'n Proto doesn't have complete support on MSVC:
:: https://github.com/sandstorm-io/capnproto/issues/227
cmake ^
    -G"%CMAKE_GENERATOR%" ^
    -DCAPNP_LITE=ON ^
    -DBUILD_TESTING=OFF ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    ..\c++
if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit 1
