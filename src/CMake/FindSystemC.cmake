set(SystemC_DIR "${CMAKE_SOURCE_DIR}/systemc-dist")

set(SystemC_INCLUDE_DIRS ${SystemC_DIR}/include )
set(SystemC_INCLUDE_DIR  ${SystemC_INCLUDE_DIRS} )
set(SystemC_CXX_LIBRARIES    ${SystemC_DIR}/lib/libsystemc.a )
set(SystemC_BYTECODE_LIBRARIES    ${SystemC_DIR}/lib_llvm/libsystemc.so )
