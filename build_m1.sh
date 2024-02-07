brew update

brew install cmake

cmake -E make_directory build

brew install pkg-config libusb fftw glfw airspy airspyhf portaudio hackrf libbladerf codec2 zstd autoconf automake libtool && pip3 install mako

git clone --recursive https://github.com/gnuradio/volk && cd volk && mkdir build && cd build && cmake -DCMAKE_OSX_ARCHITECTURES=arm64 -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 -DCMAKE_BUILD_TYPE=Release .. && make -j3 && sudo make install && cd ../../

wget https://www.sdrplay.com/software/SDRplayAPI-macos-installer-universal-3.12.1.pkg && sudo installer -pkg SDRplayAPI-macos-installer-universal-3.12.1.pkg -target /

wget https://github.com/analogdevicesinc/libiio/archive/refs/tags/v0.25.zip && 7z x v0.25.zip && cd libiio-0.25 && mkdir build && cd build && cmake -DCMAKE_OSX_ARCHITECTURES=arm64 -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 -DCMAKE_BUILD_TYPE=Release .. && make -j3 && sudo make install && cd ../../

git clone https://github.com/analogdevicesinc/libad9361-iio && cd libad9361-iio && mkdir build && cd build && cmake -DCMAKE_OSX_ARCHITECTURES=arm64 -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 -DCMAKE_BUILD_TYPE=Release .. && make -j3 && sudo make install && cd ../../

git clone https://github.com/myriadrf/LimeSuite && cd LimeSuite && mkdir builddir && cd builddir && cmake -DCMAKE_OSX_ARCHITECTURES=arm64 -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 -DCMAKE_BUILD_TYPE=Release .. && make -j3 && sudo make install && cd ../../

git clone https://github.com/Microtelecom/libperseus-sdr && cd libperseus-sdr && autoreconf -i && ./configure --prefix=/usr/local && make && make install && cd ..

git clone https://github.com/osmocom/rtl-sdr && cd rtl-sdr && mkdir build && cd build && cmake -DCMAKE_OSX_ARCHITECTURES=arm64 -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 -DCMAKE_BUILD_TYPE=Release .. && make -j3 LIBRARY_PATH=$(pkg-config --libs-only-L libusb-1.0 | sed 's/\-L//') && sudo make install && cd ../../

cmake -DCMAKE_OSX_ARCHITECTURES=arm64 -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 $GITHUB_WORKSPACE -DOPT_BUILD_PLUTOSDR_SOURCE=ON -DOPT_BUILD_SOAPY_SOURCE=OFF -DOPT_BUILD_BLADERF_SOURCE=ON -DOPT_BUILD_SDRPLAY_SOURCE=ON -DOPT_BUILD_LIMESDR_SOURCE=ON -DOPT_BUILD_AUDIO_SINK=OFF -DOPT_BUILD_PORTAUDIO_SINK=ON -DOPT_BUILD_NEW_PORTAUDIO_SINK=ON -DOPT_BUILD_M17_DECODER=ON -DOPT_BUILD_PERSEUS_SOURCE=ON -DOPT_BUILD_AUDIO_SOURCE=OFF -DUSE_BUNDLE_DEFAULTS=ON -DCMAKE_BUILD_TYPE=Release

make VERBOSE=1 -j3

cd $GITHUB_WORKSPACE && sh make_macos_bundle.sh ${{runner.workspace}}/build ./SDR++.app && zip -r ${{runner.workspace}}/sdrpp_macos_intel.zip SDR++.app