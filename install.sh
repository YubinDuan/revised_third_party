#!/bin/bash
# usage: ./install install_path
if [ $# -eq 0 ]; then
    prefix=`dirname "$0"`
    prefix=`cd "$prefix"; pwd`
else
    prefix=$1
fi

cd build
tar -zxf eigen-eigen-6b38706d90a9.tar.gz
tar -zxf glog-0.3.4.tar.gz
tar -zxf protobuf-2.5.0.tar.gz
tar -zxf gflags-2.0-no-svn-files.tar.gz
tar -zxf zeromq-4.1.0-rc1.tar.gz
tar -zxf zlib-1.2.8.tar.gz
tar -zxf snappy-1.1.2.tar.gz
tar -zxf gtest-1.7.0.tar.gz
tar -zxf libxml2-2.9.2.tar.gz

# googtest
cd gtest-1.7.0
g++ -isystem ./include -I. -pthread -c ./src/gtest-all.cc
g++ -isystem ./include -I. -pthread -c ./src/gtest_main.cc
ar -rv libgtest.a gtest-all.o
ar -rv libgtest_main.a gtest_main.o
mkdir $prefix/lib
cp libgtest* $prefix/lib
mkdir $prefix/include
cp -r ./include/gtest $prefix/include
cd ..

n=2
cd protobuf-2.5.0 && ./configure -prefix=$prefix && make -j$n && make install && cd ..
cd gflags-2.0 && ./configure -prefix=$prefix && make -j$n && make install && cd ..
cd glog-0.3.4 && ./configure -prefix=$prefix --with-gflags=$prefix && make -j$n && make install && cd ..
cd zeromq-4.1.0 && ./configure -prefix=$prefix && make -j$n && make install && cd ..
cd zlib-1.2.8 && ./configure -prefix=$prefix && make -j$n && make install && cd ..
cd snappy-1.1.2 && ./configure -prefix=$prefix && make -j$n && make install && cd ..
cd libxml2-2.9.2 && ./configure -prefix=$prefix --without-python && make -j$n && make install && mv $prefix/include/libxml2/libxml $prefix/include/libxml && rm -rf $prefix/include/libxml2 && cd .. 

cp -r eigen-eigen-6b38706d90a9/Eigen $prefix/include