module CSR(
  input         clock,
  input         reset,
  input         io__stall, // @[src/main/scala/mini/CSR.scala 123:14]
  input  [2:0]  io__cmd, // @[src/main/scala/mini/CSR.scala 123:14]
  input  [31:0] io__in, // @[src/main/scala/mini/CSR.scala 123:14]
  output [31:0] io__out, // @[src/main/scala/mini/CSR.scala 123:14]
  input  [31:0] io__pc, // @[src/main/scala/mini/CSR.scala 123:14]
  input  [31:0] io__addr, // @[src/main/scala/mini/CSR.scala 123:14]
  input  [31:0] io__inst, // @[src/main/scala/mini/CSR.scala 123:14]
  input         io__illegal, // @[src/main/scala/mini/CSR.scala 123:14]
  input  [1:0]  io__st_type, // @[src/main/scala/mini/CSR.scala 123:14]
  input  [2:0]  io__ld_type, // @[src/main/scala/mini/CSR.scala 123:14]
  input         io__pc_check, // @[src/main/scala/mini/CSR.scala 123:14]
  output        io__expt, // @[src/main/scala/mini/CSR.scala 123:14]
  output [31:0] io__evec, // @[src/main/scala/mini/CSR.scala 123:14]
  output [31:0] io__epc, // @[src/main/scala/mini/CSR.scala 123:14]
  input         io__host_fromhost_valid, // @[src/main/scala/mini/CSR.scala 123:14]
  input  [31:0] io__host_fromhost_bits, // @[src/main/scala/mini/CSR.scala 123:14]
  output [31:0] io__host_tohost, // @[src/main/scala/mini/CSR.scala 123:14]
  output        io_expt
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
`endif // RANDOMIZE_REG_INIT
  wire [11:0] csr_addr = io__inst[31:20]; // @[src/main/scala/mini/CSR.scala 125:25]
  wire [4:0] rs1_addr = io__inst[19:15]; // @[src/main/scala/mini/CSR.scala 126:25]
  reg [31:0] time_; // @[src/main/scala/mini/CSR.scala 129:21]
  reg [31:0] timeh; // @[src/main/scala/mini/CSR.scala 130:22]
  reg [31:0] cycle; // @[src/main/scala/mini/CSR.scala 131:22]
  reg [31:0] cycleh; // @[src/main/scala/mini/CSR.scala 132:23]
  reg [31:0] instret; // @[src/main/scala/mini/CSR.scala 133:24]
  reg [31:0] instreth; // @[src/main/scala/mini/CSR.scala 134:25]
  reg [1:0] PRV; // @[src/main/scala/mini/CSR.scala 146:20]
  reg [1:0] PRV1; // @[src/main/scala/mini/CSR.scala 147:21]
  reg  IE; // @[src/main/scala/mini/CSR.scala 150:19]
  reg  IE1; // @[src/main/scala/mini/CSR.scala 151:20]
  wire [31:0] mstatus = {22'h0,3'h0,1'h0,PRV1,IE1,PRV,IE}; // @[src/main/scala/mini/CSR.scala 162:20]
  reg  MTIP; // @[src/main/scala/mini/CSR.scala 167:21]
  reg  MTIE; // @[src/main/scala/mini/CSR.scala 170:21]
  reg  MSIP; // @[src/main/scala/mini/CSR.scala 173:21]
  reg  MSIE; // @[src/main/scala/mini/CSR.scala 176:21]
  wire [31:0] mip = {24'h0,MTIP,1'h0,2'h0,MSIP,1'h0,2'h0}; // @[src/main/scala/mini/CSR.scala 179:16]
  wire [31:0] mie = {24'h0,MTIE,1'h0,2'h0,MSIE,1'h0,2'h0}; // @[src/main/scala/mini/CSR.scala 180:16]
  reg [31:0] mtimecmp; // @[src/main/scala/mini/CSR.scala 182:21]
  reg [31:0] mscratch; // @[src/main/scala/mini/CSR.scala 184:21]
  reg [31:0] mepc; // @[src/main/scala/mini/CSR.scala 186:17]
  reg [31:0] mcause; // @[src/main/scala/mini/CSR.scala 188:19]
  reg [31:0] mbadaddr; // @[src/main/scala/mini/CSR.scala 189:21]
  reg [31:0] mtohost; // @[src/main/scala/mini/CSR.scala 191:24]
  reg [31:0] mfromhost; // @[src/main/scala/mini/CSR.scala 192:22]
  wire [31:0] _GEN_0 = io__host_fromhost_valid ? io__host_fromhost_bits : mfromhost; // @[src/main/scala/mini/CSR.scala 194:32 195:15 192:22]
  wire  _io_out_T_1 = 12'hc00 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_3 = 12'hc01 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_5 = 12'hc02 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_7 = 12'hc80 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_9 = 12'hc81 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_11 = 12'hc82 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_13 = 12'h900 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_15 = 12'h901 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_17 = 12'h902 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_19 = 12'h980 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_21 = 12'h981 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_23 = 12'h982 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_25 = 12'hf00 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_27 = 12'hf01 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_29 = 12'hf10 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_31 = 12'h301 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_33 = 12'h302 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_35 = 12'h304 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_37 = 12'h321 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_39 = 12'h701 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_41 = 12'h741 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_43 = 12'h340 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_45 = 12'h341 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_47 = 12'h342 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_49 = 12'h343 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_51 = 12'h344 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_53 = 12'h780 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_55 = 12'h781 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _io_out_T_57 = 12'h300 == csr_addr; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire [31:0] _io_out_T_58 = _io_out_T_57 ? mstatus : 32'h0; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_59 = _io_out_T_55 ? mfromhost : _io_out_T_58; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_60 = _io_out_T_53 ? mtohost : _io_out_T_59; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_61 = _io_out_T_51 ? mip : _io_out_T_60; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_62 = _io_out_T_49 ? mbadaddr : _io_out_T_61; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_63 = _io_out_T_47 ? mcause : _io_out_T_62; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_64 = _io_out_T_45 ? mepc : _io_out_T_63; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_65 = _io_out_T_43 ? mscratch : _io_out_T_64; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_66 = _io_out_T_41 ? timeh : _io_out_T_65; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_67 = _io_out_T_39 ? time_ : _io_out_T_66; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_68 = _io_out_T_37 ? mtimecmp : _io_out_T_67; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_69 = _io_out_T_35 ? mie : _io_out_T_68; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_70 = _io_out_T_33 ? 32'h0 : _io_out_T_69; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_71 = _io_out_T_31 ? 32'h100 : _io_out_T_70; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_72 = _io_out_T_29 ? 32'h0 : _io_out_T_71; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_73 = _io_out_T_27 ? 32'h0 : _io_out_T_72; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_74 = _io_out_T_25 ? 32'h100100 : _io_out_T_73; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_75 = _io_out_T_23 ? instreth : _io_out_T_74; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_76 = _io_out_T_21 ? timeh : _io_out_T_75; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_77 = _io_out_T_19 ? cycleh : _io_out_T_76; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_78 = _io_out_T_17 ? instret : _io_out_T_77; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_79 = _io_out_T_15 ? time_ : _io_out_T_78; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_80 = _io_out_T_13 ? cycle : _io_out_T_79; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_81 = _io_out_T_11 ? instreth : _io_out_T_80; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_82 = _io_out_T_9 ? timeh : _io_out_T_81; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_83 = _io_out_T_7 ? cycleh : _io_out_T_82; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_84 = _io_out_T_5 ? instret : _io_out_T_83; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [31:0] _io_out_T_85 = _io_out_T_3 ? time_ : _io_out_T_84; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  privValid = csr_addr[9:8] <= PRV; // @[src/main/scala/mini/CSR.scala 232:34]
  wire  privInst = io__cmd == 3'h4; // @[src/main/scala/mini/CSR.scala 233:25]
  wire  _isEcall_T_2 = privInst & ~csr_addr[0]; // @[src/main/scala/mini/CSR.scala 234:26]
  wire  _isEcall_T_4 = ~csr_addr[8]; // @[src/main/scala/mini/CSR.scala 234:45]
  wire  isEcall = privInst & ~csr_addr[0] & ~csr_addr[8]; // @[src/main/scala/mini/CSR.scala 234:42]
  wire  isEbreak = privInst & csr_addr[0] & _isEcall_T_4; // @[src/main/scala/mini/CSR.scala 235:42]
  wire  isEret = _isEcall_T_2 & csr_addr[8]; // @[src/main/scala/mini/CSR.scala 236:41]
  wire  csrValid = _io_out_T_1 | _io_out_T_3 | _io_out_T_5 | _io_out_T_7 | _io_out_T_9 | _io_out_T_11 | _io_out_T_13 |
    _io_out_T_15 | _io_out_T_17 | _io_out_T_19 | _io_out_T_21 | _io_out_T_23 | _io_out_T_25 | _io_out_T_27 |
    _io_out_T_29 | _io_out_T_31 | _io_out_T_33 | _io_out_T_35 | _io_out_T_37 | _io_out_T_39 | _io_out_T_41 |
    _io_out_T_43 | _io_out_T_45 | _io_out_T_47 | _io_out_T_49 | _io_out_T_51 | _io_out_T_53 | _io_out_T_55 |
    _io_out_T_57; // @[src/main/scala/mini/CSR.scala 237:58]
  wire  csrRO = &csr_addr[11:10] | csr_addr == 12'h301 | csr_addr == 12'h302; // @[src/main/scala/mini/CSR.scala 238:63]
  wire  wen = io__cmd == 3'h1 | io__cmd[1] & |rs1_addr; // @[src/main/scala/mini/CSR.scala 239:30]
  wire [31:0] _wdata_T = io__out | io__in; // @[src/main/scala/mini/CSR.scala 243:24]
  wire [31:0] _wdata_T_1 = ~io__in; // @[src/main/scala/mini/CSR.scala 244:26]
  wire [31:0] _wdata_T_2 = io__out & _wdata_T_1; // @[src/main/scala/mini/CSR.scala 244:24]
  wire [31:0] _wdata_T_4 = 3'h1 == io__cmd ? io__in : 32'h0; // @[src/main/scala/mini/CSR.scala 240:37]
  wire [31:0] _wdata_T_6 = 3'h2 == io__cmd ? _wdata_T : _wdata_T_4; // @[src/main/scala/mini/CSR.scala 240:37]
  wire [31:0] wdata = 3'h3 == io__cmd ? _wdata_T_2 : _wdata_T_6; // @[src/main/scala/mini/CSR.scala 240:37]
  wire  iaddrInvalid = io__pc_check & io__addr[1]; // @[src/main/scala/mini/CSR.scala 247:34]
  wire  _laddrInvalid_T_1 = |io__addr[1:0]; // @[src/main/scala/mini/CSR.scala 249:40]
  wire  _laddrInvalid_T_7 = 3'h2 == io__ld_type ? io__addr[0] : 3'h1 == io__ld_type & _laddrInvalid_T_1; // @[src/main/scala/mini/CSR.scala 248:52]
  wire  laddrInvalid = 3'h4 == io__ld_type ? io__addr[0] : _laddrInvalid_T_7; // @[src/main/scala/mini/CSR.scala 248:52]
  wire  saddrInvalid = 2'h2 == io__st_type ? io__addr[0] : 2'h1 == io__st_type & _laddrInvalid_T_1; // @[src/main/scala/mini/CSR.scala 252:35]
  wire  _io_expt_T_6 = ~privValid; // @[src/main/scala/mini/CSR.scala 254:39]
  wire  _io_expt_T_8 = |io__cmd[1:0] & (~csrValid | ~privValid); // @[src/main/scala/mini/CSR.scala 254:22]
  wire  _io_expt_T_9 = io__illegal | iaddrInvalid | laddrInvalid | saddrInvalid | _io_expt_T_8; // @[src/main/scala/mini/CSR.scala 253:73]
  wire  _io_expt_T_13 = privInst & _io_expt_T_6; // @[src/main/scala/mini/CSR.scala 255:15]
  wire  _io_expt_T_14 = _io_expt_T_9 | wen & csrRO | _io_expt_T_13; // @[src/main/scala/mini/CSR.scala 254:67]
  wire [7:0] _io_evec_T = {PRV, 6'h0}; // @[src/main/scala/mini/CSR.scala 256:27]
  wire [31:0] _GEN_260 = {{24'd0}, _io_evec_T}; // @[src/main/scala/mini/CSR.scala 256:20]
  wire [31:0] _time_T_1 = time_ + 32'h1; // @[src/main/scala/mini/CSR.scala 260:16]
  wire [31:0] _timeh_T_1 = timeh + 32'h1; // @[src/main/scala/mini/CSR.scala 261:36]
  wire [31:0] _GEN_1 = &time_ ? _timeh_T_1 : timeh; // @[src/main/scala/mini/CSR.scala 261:19 130:22 261:27]
  wire [31:0] _cycle_T_1 = cycle + 32'h1; // @[src/main/scala/mini/CSR.scala 262:18]
  wire [31:0] _cycleh_T_1 = cycleh + 32'h1; // @[src/main/scala/mini/CSR.scala 263:39]
  wire [31:0] _GEN_2 = &cycle ? _cycleh_T_1 : cycleh; // @[src/main/scala/mini/CSR.scala 263:20 132:23 263:29]
  wire  _isInstRet_T_5 = ~io__stall; // @[src/main/scala/mini/CSR.scala 264:88]
  wire  isInstRet = io__inst != 32'h13 & (~io__expt | isEcall | isEbreak) & ~io__stall; // @[src/main/scala/mini/CSR.scala 264:85]
  wire [31:0] _instret_T_1 = instret + 32'h1; // @[src/main/scala/mini/CSR.scala 265:40]
  wire [31:0] _GEN_3 = isInstRet ? _instret_T_1 : instret; // @[src/main/scala/mini/CSR.scala 265:19 133:24 265:29]
  wire [31:0] _instreth_T_1 = instreth + 32'h1; // @[src/main/scala/mini/CSR.scala 266:58]
  wire [31:0] _GEN_4 = isInstRet & &instret ? _instreth_T_1 : instreth; // @[src/main/scala/mini/CSR.scala 134:25 266:{35,46}]
  wire [31:0] _mepc_T_1 = {io__pc[31:2], 2'h0}; // @[src/main/scala/mini/CSR.scala 272:26]
  wire [3:0] _GEN_261 = {{2'd0}, PRV}; // @[src/main/scala/mini/CSR.scala 282:38]
  wire [3:0] _mcause_T_1 = 4'h8 + _GEN_261; // @[src/main/scala/mini/CSR.scala 282:38]
  wire [1:0] _mcause_T_2 = isEbreak ? 2'h3 : 2'h2; // @[src/main/scala/mini/CSR.scala 282:48]
  wire [3:0] _mcause_T_3 = isEcall ? _mcause_T_1 : {{2'd0}, _mcause_T_2}; // @[src/main/scala/mini/CSR.scala 282:16]
  wire [3:0] _mcause_T_4 = saddrInvalid ? 4'h6 : _mcause_T_3; // @[src/main/scala/mini/CSR.scala 279:14]
  wire [3:0] _mcause_T_5 = laddrInvalid ? 4'h4 : _mcause_T_4; // @[src/main/scala/mini/CSR.scala 276:12]
  wire [3:0] _mcause_T_6 = iaddrInvalid ? 4'h0 : _mcause_T_5; // @[src/main/scala/mini/CSR.scala 273:20]
  wire [31:0] _mepc_T_2 = {{2'd0}, wdata[31:2]}; // @[src/main/scala/mini/CSR.scala 315:58]
  wire [33:0] _GEN_263 = {_mepc_T_2, 2'h0}; // @[src/main/scala/mini/CSR.scala 315:65]
  wire [34:0] _mepc_T_3 = {{1'd0}, _GEN_263}; // @[src/main/scala/mini/CSR.scala 315:65]
  wire [31:0] _mcause_T_7 = wdata & 32'h8000000f; // @[src/main/scala/mini/CSR.scala 316:62]
  wire [31:0] _GEN_6 = csr_addr == 12'h982 ? wdata : _GEN_4; // @[src/main/scala/mini/CSR.scala 325:{47,58}]
  wire [31:0] _GEN_7 = csr_addr == 12'h981 ? wdata : _GEN_1; // @[src/main/scala/mini/CSR.scala 324:{44,52}]
  wire [31:0] _GEN_8 = csr_addr == 12'h981 ? _GEN_4 : _GEN_6; // @[src/main/scala/mini/CSR.scala 324:44]
  wire [31:0] _GEN_9 = csr_addr == 12'h980 ? wdata : _GEN_2; // @[src/main/scala/mini/CSR.scala 323:{45,54}]
  wire [31:0] _GEN_10 = csr_addr == 12'h980 ? _GEN_1 : _GEN_7; // @[src/main/scala/mini/CSR.scala 323:45]
  wire [31:0] _GEN_11 = csr_addr == 12'h980 ? _GEN_4 : _GEN_8; // @[src/main/scala/mini/CSR.scala 323:45]
  wire [31:0] _GEN_12 = csr_addr == 12'h902 ? wdata : _GEN_3; // @[src/main/scala/mini/CSR.scala 322:{46,56}]
  wire [31:0] _GEN_13 = csr_addr == 12'h902 ? _GEN_2 : _GEN_9; // @[src/main/scala/mini/CSR.scala 322:46]
  wire [31:0] _GEN_14 = csr_addr == 12'h902 ? _GEN_1 : _GEN_10; // @[src/main/scala/mini/CSR.scala 322:46]
  wire [31:0] _GEN_15 = csr_addr == 12'h902 ? _GEN_4 : _GEN_11; // @[src/main/scala/mini/CSR.scala 322:46]
  wire [31:0] _GEN_16 = csr_addr == 12'h901 ? wdata : _time_T_1; // @[src/main/scala/mini/CSR.scala 321:{43,50} 260:8]
  wire [31:0] _GEN_17 = csr_addr == 12'h901 ? _GEN_3 : _GEN_12; // @[src/main/scala/mini/CSR.scala 321:43]
  wire [31:0] _GEN_18 = csr_addr == 12'h901 ? _GEN_2 : _GEN_13; // @[src/main/scala/mini/CSR.scala 321:43]
  wire [31:0] _GEN_19 = csr_addr == 12'h901 ? _GEN_1 : _GEN_14; // @[src/main/scala/mini/CSR.scala 321:43]
  wire [31:0] _GEN_20 = csr_addr == 12'h901 ? _GEN_4 : _GEN_15; // @[src/main/scala/mini/CSR.scala 321:43]
  wire [31:0] _GEN_21 = csr_addr == 12'h900 ? wdata : _cycle_T_1; // @[src/main/scala/mini/CSR.scala 320:{44,52} 262:9]
  wire [31:0] _GEN_22 = csr_addr == 12'h900 ? _time_T_1 : _GEN_16; // @[src/main/scala/mini/CSR.scala 320:44 260:8]
  wire [31:0] _GEN_23 = csr_addr == 12'h900 ? _GEN_3 : _GEN_17; // @[src/main/scala/mini/CSR.scala 320:44]
  wire [31:0] _GEN_24 = csr_addr == 12'h900 ? _GEN_2 : _GEN_18; // @[src/main/scala/mini/CSR.scala 320:44]
  wire [31:0] _GEN_25 = csr_addr == 12'h900 ? _GEN_1 : _GEN_19; // @[src/main/scala/mini/CSR.scala 320:44]
  wire [31:0] _GEN_26 = csr_addr == 12'h900 ? _GEN_4 : _GEN_20; // @[src/main/scala/mini/CSR.scala 320:44]
  wire [31:0] _GEN_27 = csr_addr == 12'h781 ? wdata : _GEN_0; // @[src/main/scala/mini/CSR.scala 319:{47,59}]
  wire [31:0] _GEN_28 = csr_addr == 12'h781 ? _cycle_T_1 : _GEN_21; // @[src/main/scala/mini/CSR.scala 319:47 262:9]
  wire [31:0] _GEN_29 = csr_addr == 12'h781 ? _time_T_1 : _GEN_22; // @[src/main/scala/mini/CSR.scala 319:47 260:8]
  wire [31:0] _GEN_30 = csr_addr == 12'h781 ? _GEN_3 : _GEN_23; // @[src/main/scala/mini/CSR.scala 319:47]
  wire [31:0] _GEN_31 = csr_addr == 12'h781 ? _GEN_2 : _GEN_24; // @[src/main/scala/mini/CSR.scala 319:47]
  wire [31:0] _GEN_32 = csr_addr == 12'h781 ? _GEN_1 : _GEN_25; // @[src/main/scala/mini/CSR.scala 319:47]
  wire [31:0] _GEN_33 = csr_addr == 12'h781 ? _GEN_4 : _GEN_26; // @[src/main/scala/mini/CSR.scala 319:47]
  wire [31:0] _GEN_34 = csr_addr == 12'h780 ? wdata : mtohost; // @[src/main/scala/mini/CSR.scala 191:24 318:{45,55}]
  wire [31:0] _GEN_35 = csr_addr == 12'h780 ? _GEN_0 : _GEN_27; // @[src/main/scala/mini/CSR.scala 318:45]
  wire [31:0] _GEN_36 = csr_addr == 12'h780 ? _cycle_T_1 : _GEN_28; // @[src/main/scala/mini/CSR.scala 318:45 262:9]
  wire [31:0] _GEN_37 = csr_addr == 12'h780 ? _time_T_1 : _GEN_29; // @[src/main/scala/mini/CSR.scala 318:45 260:8]
  wire [31:0] _GEN_38 = csr_addr == 12'h780 ? _GEN_3 : _GEN_30; // @[src/main/scala/mini/CSR.scala 318:45]
  wire [31:0] _GEN_39 = csr_addr == 12'h780 ? _GEN_2 : _GEN_31; // @[src/main/scala/mini/CSR.scala 318:45]
  wire [31:0] _GEN_40 = csr_addr == 12'h780 ? _GEN_1 : _GEN_32; // @[src/main/scala/mini/CSR.scala 318:45]
  wire [31:0] _GEN_41 = csr_addr == 12'h780 ? _GEN_4 : _GEN_33; // @[src/main/scala/mini/CSR.scala 318:45]
  wire [31:0] _GEN_42 = csr_addr == 12'h343 ? wdata : mbadaddr; // @[src/main/scala/mini/CSR.scala 189:21 317:{46,57}]
  wire [31:0] _GEN_43 = csr_addr == 12'h343 ? mtohost : _GEN_34; // @[src/main/scala/mini/CSR.scala 191:24 317:46]
  wire [31:0] _GEN_44 = csr_addr == 12'h343 ? _GEN_0 : _GEN_35; // @[src/main/scala/mini/CSR.scala 317:46]
  wire [31:0] _GEN_45 = csr_addr == 12'h343 ? _cycle_T_1 : _GEN_36; // @[src/main/scala/mini/CSR.scala 317:46 262:9]
  wire [31:0] _GEN_46 = csr_addr == 12'h343 ? _time_T_1 : _GEN_37; // @[src/main/scala/mini/CSR.scala 317:46 260:8]
  wire [31:0] _GEN_47 = csr_addr == 12'h343 ? _GEN_3 : _GEN_38; // @[src/main/scala/mini/CSR.scala 317:46]
  wire [31:0] _GEN_48 = csr_addr == 12'h343 ? _GEN_2 : _GEN_39; // @[src/main/scala/mini/CSR.scala 317:46]
  wire [31:0] _GEN_49 = csr_addr == 12'h343 ? _GEN_1 : _GEN_40; // @[src/main/scala/mini/CSR.scala 317:46]
  wire [31:0] _GEN_50 = csr_addr == 12'h343 ? _GEN_4 : _GEN_41; // @[src/main/scala/mini/CSR.scala 317:46]
  wire [31:0] _GEN_51 = csr_addr == 12'h342 ? _mcause_T_7 : mcause; // @[src/main/scala/mini/CSR.scala 188:19 316:{44,53}]
  wire [31:0] _GEN_52 = csr_addr == 12'h342 ? mbadaddr : _GEN_42; // @[src/main/scala/mini/CSR.scala 189:21 316:44]
  wire [31:0] _GEN_53 = csr_addr == 12'h342 ? mtohost : _GEN_43; // @[src/main/scala/mini/CSR.scala 191:24 316:44]
  wire [31:0] _GEN_54 = csr_addr == 12'h342 ? _GEN_0 : _GEN_44; // @[src/main/scala/mini/CSR.scala 316:44]
  wire [31:0] _GEN_55 = csr_addr == 12'h342 ? _cycle_T_1 : _GEN_45; // @[src/main/scala/mini/CSR.scala 316:44 262:9]
  wire [31:0] _GEN_56 = csr_addr == 12'h342 ? _time_T_1 : _GEN_46; // @[src/main/scala/mini/CSR.scala 316:44 260:8]
  wire [31:0] _GEN_57 = csr_addr == 12'h342 ? _GEN_3 : _GEN_47; // @[src/main/scala/mini/CSR.scala 316:44]
  wire [31:0] _GEN_58 = csr_addr == 12'h342 ? _GEN_2 : _GEN_48; // @[src/main/scala/mini/CSR.scala 316:44]
  wire [31:0] _GEN_59 = csr_addr == 12'h342 ? _GEN_1 : _GEN_49; // @[src/main/scala/mini/CSR.scala 316:44]
  wire [31:0] _GEN_60 = csr_addr == 12'h342 ? _GEN_4 : _GEN_50; // @[src/main/scala/mini/CSR.scala 316:44]
  wire [34:0] _GEN_61 = csr_addr == 12'h341 ? _mepc_T_3 : {{3'd0}, mepc}; // @[src/main/scala/mini/CSR.scala 186:17 315:{42,49}]
  wire [31:0] _GEN_62 = csr_addr == 12'h341 ? mcause : _GEN_51; // @[src/main/scala/mini/CSR.scala 188:19 315:42]
  wire [31:0] _GEN_63 = csr_addr == 12'h341 ? mbadaddr : _GEN_52; // @[src/main/scala/mini/CSR.scala 189:21 315:42]
  wire [31:0] _GEN_64 = csr_addr == 12'h341 ? mtohost : _GEN_53; // @[src/main/scala/mini/CSR.scala 191:24 315:42]
  wire [31:0] _GEN_65 = csr_addr == 12'h341 ? _GEN_0 : _GEN_54; // @[src/main/scala/mini/CSR.scala 315:42]
  wire [31:0] _GEN_66 = csr_addr == 12'h341 ? _cycle_T_1 : _GEN_55; // @[src/main/scala/mini/CSR.scala 315:42 262:9]
  wire [31:0] _GEN_67 = csr_addr == 12'h341 ? _time_T_1 : _GEN_56; // @[src/main/scala/mini/CSR.scala 315:42 260:8]
  wire [31:0] _GEN_68 = csr_addr == 12'h341 ? _GEN_3 : _GEN_57; // @[src/main/scala/mini/CSR.scala 315:42]
  wire [31:0] _GEN_69 = csr_addr == 12'h341 ? _GEN_2 : _GEN_58; // @[src/main/scala/mini/CSR.scala 315:42]
  wire [31:0] _GEN_70 = csr_addr == 12'h341 ? _GEN_1 : _GEN_59; // @[src/main/scala/mini/CSR.scala 315:42]
  wire [31:0] _GEN_71 = csr_addr == 12'h341 ? _GEN_4 : _GEN_60; // @[src/main/scala/mini/CSR.scala 315:42]
  wire [31:0] _GEN_72 = csr_addr == 12'h340 ? wdata : mscratch; // @[src/main/scala/mini/CSR.scala 184:21 314:{46,57}]
  wire [34:0] _GEN_73 = csr_addr == 12'h340 ? {{3'd0}, mepc} : _GEN_61; // @[src/main/scala/mini/CSR.scala 186:17 314:46]
  wire [31:0] _GEN_74 = csr_addr == 12'h340 ? mcause : _GEN_62; // @[src/main/scala/mini/CSR.scala 188:19 314:46]
  wire [31:0] _GEN_75 = csr_addr == 12'h340 ? mbadaddr : _GEN_63; // @[src/main/scala/mini/CSR.scala 189:21 314:46]
  wire [31:0] _GEN_76 = csr_addr == 12'h340 ? mtohost : _GEN_64; // @[src/main/scala/mini/CSR.scala 191:24 314:46]
  wire [31:0] _GEN_77 = csr_addr == 12'h340 ? _GEN_0 : _GEN_65; // @[src/main/scala/mini/CSR.scala 314:46]
  wire [31:0] _GEN_78 = csr_addr == 12'h340 ? _cycle_T_1 : _GEN_66; // @[src/main/scala/mini/CSR.scala 314:46 262:9]
  wire [31:0] _GEN_79 = csr_addr == 12'h340 ? _time_T_1 : _GEN_67; // @[src/main/scala/mini/CSR.scala 314:46 260:8]
  wire [31:0] _GEN_80 = csr_addr == 12'h340 ? _GEN_3 : _GEN_68; // @[src/main/scala/mini/CSR.scala 314:46]
  wire [31:0] _GEN_81 = csr_addr == 12'h340 ? _GEN_2 : _GEN_69; // @[src/main/scala/mini/CSR.scala 314:46]
  wire [31:0] _GEN_82 = csr_addr == 12'h340 ? _GEN_1 : _GEN_70; // @[src/main/scala/mini/CSR.scala 314:46]
  wire [31:0] _GEN_83 = csr_addr == 12'h340 ? _GEN_4 : _GEN_71; // @[src/main/scala/mini/CSR.scala 314:46]
  wire [31:0] _GEN_84 = csr_addr == 12'h321 ? wdata : mtimecmp; // @[src/main/scala/mini/CSR.scala 182:21 313:{46,57}]
  wire [31:0] _GEN_85 = csr_addr == 12'h321 ? mscratch : _GEN_72; // @[src/main/scala/mini/CSR.scala 184:21 313:46]
  wire [34:0] _GEN_86 = csr_addr == 12'h321 ? {{3'd0}, mepc} : _GEN_73; // @[src/main/scala/mini/CSR.scala 186:17 313:46]
  wire [31:0] _GEN_87 = csr_addr == 12'h321 ? mcause : _GEN_74; // @[src/main/scala/mini/CSR.scala 188:19 313:46]
  wire [31:0] _GEN_88 = csr_addr == 12'h321 ? mbadaddr : _GEN_75; // @[src/main/scala/mini/CSR.scala 189:21 313:46]
  wire [31:0] _GEN_89 = csr_addr == 12'h321 ? mtohost : _GEN_76; // @[src/main/scala/mini/CSR.scala 191:24 313:46]
  wire [31:0] _GEN_90 = csr_addr == 12'h321 ? _GEN_0 : _GEN_77; // @[src/main/scala/mini/CSR.scala 313:46]
  wire [31:0] _GEN_91 = csr_addr == 12'h321 ? _cycle_T_1 : _GEN_78; // @[src/main/scala/mini/CSR.scala 313:46 262:9]
  wire [31:0] _GEN_92 = csr_addr == 12'h321 ? _time_T_1 : _GEN_79; // @[src/main/scala/mini/CSR.scala 313:46 260:8]
  wire [31:0] _GEN_93 = csr_addr == 12'h321 ? _GEN_3 : _GEN_80; // @[src/main/scala/mini/CSR.scala 313:46]
  wire [31:0] _GEN_94 = csr_addr == 12'h321 ? _GEN_2 : _GEN_81; // @[src/main/scala/mini/CSR.scala 313:46]
  wire [31:0] _GEN_95 = csr_addr == 12'h321 ? _GEN_1 : _GEN_82; // @[src/main/scala/mini/CSR.scala 313:46]
  wire [31:0] _GEN_96 = csr_addr == 12'h321 ? _GEN_4 : _GEN_83; // @[src/main/scala/mini/CSR.scala 313:46]
  wire [31:0] _GEN_97 = csr_addr == 12'h741 ? wdata : _GEN_95; // @[src/main/scala/mini/CSR.scala 312:{44,52}]
  wire [31:0] _GEN_98 = csr_addr == 12'h741 ? mtimecmp : _GEN_84; // @[src/main/scala/mini/CSR.scala 182:21 312:44]
  wire [31:0] _GEN_99 = csr_addr == 12'h741 ? mscratch : _GEN_85; // @[src/main/scala/mini/CSR.scala 184:21 312:44]
  wire [34:0] _GEN_100 = csr_addr == 12'h741 ? {{3'd0}, mepc} : _GEN_86; // @[src/main/scala/mini/CSR.scala 186:17 312:44]
  wire [31:0] _GEN_101 = csr_addr == 12'h741 ? mcause : _GEN_87; // @[src/main/scala/mini/CSR.scala 188:19 312:44]
  wire [31:0] _GEN_102 = csr_addr == 12'h741 ? mbadaddr : _GEN_88; // @[src/main/scala/mini/CSR.scala 189:21 312:44]
  wire [31:0] _GEN_103 = csr_addr == 12'h741 ? mtohost : _GEN_89; // @[src/main/scala/mini/CSR.scala 191:24 312:44]
  wire [31:0] _GEN_104 = csr_addr == 12'h741 ? _GEN_0 : _GEN_90; // @[src/main/scala/mini/CSR.scala 312:44]
  wire [31:0] _GEN_105 = csr_addr == 12'h741 ? _cycle_T_1 : _GEN_91; // @[src/main/scala/mini/CSR.scala 312:44 262:9]
  wire [31:0] _GEN_106 = csr_addr == 12'h741 ? _time_T_1 : _GEN_92; // @[src/main/scala/mini/CSR.scala 312:44 260:8]
  wire [31:0] _GEN_107 = csr_addr == 12'h741 ? _GEN_3 : _GEN_93; // @[src/main/scala/mini/CSR.scala 312:44]
  wire [31:0] _GEN_108 = csr_addr == 12'h741 ? _GEN_2 : _GEN_94; // @[src/main/scala/mini/CSR.scala 312:44]
  wire [31:0] _GEN_109 = csr_addr == 12'h741 ? _GEN_4 : _GEN_96; // @[src/main/scala/mini/CSR.scala 312:44]
  wire [31:0] _GEN_110 = csr_addr == 12'h701 ? wdata : _GEN_106; // @[src/main/scala/mini/CSR.scala 311:{43,50}]
  wire [31:0] _GEN_111 = csr_addr == 12'h701 ? _GEN_1 : _GEN_97; // @[src/main/scala/mini/CSR.scala 311:43]
  wire [31:0] _GEN_112 = csr_addr == 12'h701 ? mtimecmp : _GEN_98; // @[src/main/scala/mini/CSR.scala 182:21 311:43]
  wire [31:0] _GEN_113 = csr_addr == 12'h701 ? mscratch : _GEN_99; // @[src/main/scala/mini/CSR.scala 184:21 311:43]
  wire [34:0] _GEN_114 = csr_addr == 12'h701 ? {{3'd0}, mepc} : _GEN_100; // @[src/main/scala/mini/CSR.scala 186:17 311:43]
  wire [31:0] _GEN_115 = csr_addr == 12'h701 ? mcause : _GEN_101; // @[src/main/scala/mini/CSR.scala 188:19 311:43]
  wire [31:0] _GEN_116 = csr_addr == 12'h701 ? mbadaddr : _GEN_102; // @[src/main/scala/mini/CSR.scala 189:21 311:43]
  wire [31:0] _GEN_117 = csr_addr == 12'h701 ? mtohost : _GEN_103; // @[src/main/scala/mini/CSR.scala 191:24 311:43]
  wire [31:0] _GEN_118 = csr_addr == 12'h701 ? _GEN_0 : _GEN_104; // @[src/main/scala/mini/CSR.scala 311:43]
  wire [31:0] _GEN_119 = csr_addr == 12'h701 ? _cycle_T_1 : _GEN_105; // @[src/main/scala/mini/CSR.scala 311:43 262:9]
  wire [31:0] _GEN_120 = csr_addr == 12'h701 ? _GEN_3 : _GEN_107; // @[src/main/scala/mini/CSR.scala 311:43]
  wire [31:0] _GEN_121 = csr_addr == 12'h701 ? _GEN_2 : _GEN_108; // @[src/main/scala/mini/CSR.scala 311:43]
  wire [31:0] _GEN_122 = csr_addr == 12'h701 ? _GEN_4 : _GEN_109; // @[src/main/scala/mini/CSR.scala 311:43]
  wire  _GEN_123 = csr_addr == 12'h304 ? wdata[7] : MTIE; // @[src/main/scala/mini/CSR.scala 307:41 308:16 170:21]
  wire  _GEN_124 = csr_addr == 12'h304 ? wdata[3] : MSIE; // @[src/main/scala/mini/CSR.scala 307:41 309:16 176:21]
  wire [31:0] _GEN_125 = csr_addr == 12'h304 ? _time_T_1 : _GEN_110; // @[src/main/scala/mini/CSR.scala 307:41 260:8]
  wire [31:0] _GEN_126 = csr_addr == 12'h304 ? _GEN_1 : _GEN_111; // @[src/main/scala/mini/CSR.scala 307:41]
  wire [31:0] _GEN_127 = csr_addr == 12'h304 ? mtimecmp : _GEN_112; // @[src/main/scala/mini/CSR.scala 182:21 307:41]
  wire [31:0] _GEN_128 = csr_addr == 12'h304 ? mscratch : _GEN_113; // @[src/main/scala/mini/CSR.scala 184:21 307:41]
  wire [34:0] _GEN_129 = csr_addr == 12'h304 ? {{3'd0}, mepc} : _GEN_114; // @[src/main/scala/mini/CSR.scala 186:17 307:41]
  wire [31:0] _GEN_130 = csr_addr == 12'h304 ? mcause : _GEN_115; // @[src/main/scala/mini/CSR.scala 188:19 307:41]
  wire [31:0] _GEN_131 = csr_addr == 12'h304 ? mbadaddr : _GEN_116; // @[src/main/scala/mini/CSR.scala 189:21 307:41]
  wire [31:0] _GEN_132 = csr_addr == 12'h304 ? mtohost : _GEN_117; // @[src/main/scala/mini/CSR.scala 191:24 307:41]
  wire [31:0] _GEN_133 = csr_addr == 12'h304 ? _GEN_0 : _GEN_118; // @[src/main/scala/mini/CSR.scala 307:41]
  wire [31:0] _GEN_134 = csr_addr == 12'h304 ? _cycle_T_1 : _GEN_119; // @[src/main/scala/mini/CSR.scala 307:41 262:9]
  wire [31:0] _GEN_135 = csr_addr == 12'h304 ? _GEN_3 : _GEN_120; // @[src/main/scala/mini/CSR.scala 307:41]
  wire [31:0] _GEN_136 = csr_addr == 12'h304 ? _GEN_2 : _GEN_121; // @[src/main/scala/mini/CSR.scala 307:41]
  wire [31:0] _GEN_137 = csr_addr == 12'h304 ? _GEN_4 : _GEN_122; // @[src/main/scala/mini/CSR.scala 307:41]
  wire  _GEN_138 = csr_addr == 12'h344 ? wdata[7] : MTIP; // @[src/main/scala/mini/CSR.scala 303:41 304:16 167:21]
  wire  _GEN_139 = csr_addr == 12'h344 ? wdata[3] : MSIP; // @[src/main/scala/mini/CSR.scala 303:41 305:16 173:21]
  wire  _GEN_140 = csr_addr == 12'h344 ? MTIE : _GEN_123; // @[src/main/scala/mini/CSR.scala 170:21 303:41]
  wire  _GEN_141 = csr_addr == 12'h344 ? MSIE : _GEN_124; // @[src/main/scala/mini/CSR.scala 176:21 303:41]
  wire [31:0] _GEN_142 = csr_addr == 12'h344 ? _time_T_1 : _GEN_125; // @[src/main/scala/mini/CSR.scala 303:41 260:8]
  wire [31:0] _GEN_143 = csr_addr == 12'h344 ? _GEN_1 : _GEN_126; // @[src/main/scala/mini/CSR.scala 303:41]
  wire [31:0] _GEN_144 = csr_addr == 12'h344 ? mtimecmp : _GEN_127; // @[src/main/scala/mini/CSR.scala 182:21 303:41]
  wire [31:0] _GEN_145 = csr_addr == 12'h344 ? mscratch : _GEN_128; // @[src/main/scala/mini/CSR.scala 184:21 303:41]
  wire [34:0] _GEN_146 = csr_addr == 12'h344 ? {{3'd0}, mepc} : _GEN_129; // @[src/main/scala/mini/CSR.scala 186:17 303:41]
  wire [31:0] _GEN_147 = csr_addr == 12'h344 ? mcause : _GEN_130; // @[src/main/scala/mini/CSR.scala 188:19 303:41]
  wire [31:0] _GEN_148 = csr_addr == 12'h344 ? mbadaddr : _GEN_131; // @[src/main/scala/mini/CSR.scala 189:21 303:41]
  wire [31:0] _GEN_149 = csr_addr == 12'h344 ? mtohost : _GEN_132; // @[src/main/scala/mini/CSR.scala 191:24 303:41]
  wire [31:0] _GEN_150 = csr_addr == 12'h344 ? _GEN_0 : _GEN_133; // @[src/main/scala/mini/CSR.scala 303:41]
  wire [31:0] _GEN_151 = csr_addr == 12'h344 ? _cycle_T_1 : _GEN_134; // @[src/main/scala/mini/CSR.scala 303:41 262:9]
  wire [31:0] _GEN_152 = csr_addr == 12'h344 ? _GEN_3 : _GEN_135; // @[src/main/scala/mini/CSR.scala 303:41]
  wire [31:0] _GEN_153 = csr_addr == 12'h344 ? _GEN_2 : _GEN_136; // @[src/main/scala/mini/CSR.scala 303:41]
  wire [31:0] _GEN_154 = csr_addr == 12'h344 ? _GEN_4 : _GEN_137; // @[src/main/scala/mini/CSR.scala 303:41]
  wire [1:0] _GEN_155 = csr_addr == 12'h300 ? wdata[5:4] : PRV1; // @[src/main/scala/mini/CSR.scala 297:38 298:14 147:21]
  wire  _GEN_156 = csr_addr == 12'h300 ? wdata[3] : IE1; // @[src/main/scala/mini/CSR.scala 297:38 299:13 151:20]
  wire [1:0] _GEN_157 = csr_addr == 12'h300 ? wdata[2:1] : PRV; // @[src/main/scala/mini/CSR.scala 297:38 300:13 146:20]
  wire  _GEN_158 = csr_addr == 12'h300 ? wdata[0] : IE; // @[src/main/scala/mini/CSR.scala 297:38 301:12 150:19]
  wire  _GEN_159 = csr_addr == 12'h300 ? MTIP : _GEN_138; // @[src/main/scala/mini/CSR.scala 167:21 297:38]
  wire  _GEN_160 = csr_addr == 12'h300 ? MSIP : _GEN_139; // @[src/main/scala/mini/CSR.scala 173:21 297:38]
  wire  _GEN_161 = csr_addr == 12'h300 ? MTIE : _GEN_140; // @[src/main/scala/mini/CSR.scala 170:21 297:38]
  wire  _GEN_162 = csr_addr == 12'h300 ? MSIE : _GEN_141; // @[src/main/scala/mini/CSR.scala 176:21 297:38]
  wire [31:0] _GEN_163 = csr_addr == 12'h300 ? _time_T_1 : _GEN_142; // @[src/main/scala/mini/CSR.scala 297:38 260:8]
  wire [31:0] _GEN_164 = csr_addr == 12'h300 ? _GEN_1 : _GEN_143; // @[src/main/scala/mini/CSR.scala 297:38]
  wire [31:0] _GEN_165 = csr_addr == 12'h300 ? mtimecmp : _GEN_144; // @[src/main/scala/mini/CSR.scala 182:21 297:38]
  wire [31:0] _GEN_166 = csr_addr == 12'h300 ? mscratch : _GEN_145; // @[src/main/scala/mini/CSR.scala 184:21 297:38]
  wire [34:0] _GEN_167 = csr_addr == 12'h300 ? {{3'd0}, mepc} : _GEN_146; // @[src/main/scala/mini/CSR.scala 186:17 297:38]
  wire [31:0] _GEN_168 = csr_addr == 12'h300 ? mcause : _GEN_147; // @[src/main/scala/mini/CSR.scala 188:19 297:38]
  wire [31:0] _GEN_169 = csr_addr == 12'h300 ? mbadaddr : _GEN_148; // @[src/main/scala/mini/CSR.scala 189:21 297:38]
  wire [31:0] _GEN_170 = csr_addr == 12'h300 ? mtohost : _GEN_149; // @[src/main/scala/mini/CSR.scala 191:24 297:38]
  wire [31:0] _GEN_171 = csr_addr == 12'h300 ? _GEN_0 : _GEN_150; // @[src/main/scala/mini/CSR.scala 297:38]
  wire [31:0] _GEN_172 = csr_addr == 12'h300 ? _cycle_T_1 : _GEN_151; // @[src/main/scala/mini/CSR.scala 297:38 262:9]
  wire [31:0] _GEN_173 = csr_addr == 12'h300 ? _GEN_3 : _GEN_152; // @[src/main/scala/mini/CSR.scala 297:38]
  wire [31:0] _GEN_174 = csr_addr == 12'h300 ? _GEN_2 : _GEN_153; // @[src/main/scala/mini/CSR.scala 297:38]
  wire [31:0] _GEN_175 = csr_addr == 12'h300 ? _GEN_4 : _GEN_154; // @[src/main/scala/mini/CSR.scala 297:38]
  wire [1:0] _GEN_176 = wen ? _GEN_155 : PRV1; // @[src/main/scala/mini/CSR.scala 147:21 296:21]
  wire  _GEN_177 = wen ? _GEN_156 : IE1; // @[src/main/scala/mini/CSR.scala 151:20 296:21]
  wire [1:0] _GEN_178 = wen ? _GEN_157 : PRV; // @[src/main/scala/mini/CSR.scala 146:20 296:21]
  wire  _GEN_179 = wen ? _GEN_158 : IE; // @[src/main/scala/mini/CSR.scala 150:19 296:21]
  wire  _GEN_180 = wen ? _GEN_159 : MTIP; // @[src/main/scala/mini/CSR.scala 167:21 296:21]
  wire  _GEN_181 = wen ? _GEN_160 : MSIP; // @[src/main/scala/mini/CSR.scala 173:21 296:21]
  wire  _GEN_182 = wen ? _GEN_161 : MTIE; // @[src/main/scala/mini/CSR.scala 170:21 296:21]
  wire  _GEN_183 = wen ? _GEN_162 : MSIE; // @[src/main/scala/mini/CSR.scala 176:21 296:21]
  wire [31:0] _GEN_184 = wen ? _GEN_163 : _time_T_1; // @[src/main/scala/mini/CSR.scala 296:21 260:8]
  wire [31:0] _GEN_185 = wen ? _GEN_164 : _GEN_1; // @[src/main/scala/mini/CSR.scala 296:21]
  wire [34:0] _GEN_188 = wen ? _GEN_167 : {{3'd0}, mepc}; // @[src/main/scala/mini/CSR.scala 186:17 296:21]
  wire [31:0] _GEN_191 = wen ? _GEN_170 : mtohost; // @[src/main/scala/mini/CSR.scala 296:21 191:24]
  wire [31:0] _GEN_193 = wen ? _GEN_172 : _cycle_T_1; // @[src/main/scala/mini/CSR.scala 296:21 262:9]
  wire [31:0] _GEN_194 = wen ? _GEN_173 : _GEN_3; // @[src/main/scala/mini/CSR.scala 296:21]
  wire [31:0] _GEN_195 = wen ? _GEN_174 : _GEN_2; // @[src/main/scala/mini/CSR.scala 296:21]
  wire [31:0] _GEN_196 = wen ? _GEN_175 : _GEN_4; // @[src/main/scala/mini/CSR.scala 296:21]
  wire  _GEN_200 = isEret | _GEN_177; // @[src/main/scala/mini/CSR.scala 291:24 295:11]
  wire [34:0] _GEN_209 = isEret ? {{3'd0}, mepc} : _GEN_188; // @[src/main/scala/mini/CSR.scala 186:17 291:24]
  wire [34:0] _GEN_218 = io__expt ? {{3'd0}, _mepc_T_1} : _GEN_209; // @[src/main/scala/mini/CSR.scala 271:19 272:12]
  wire [34:0] _GEN_239 = _isInstRet_T_5 ? _GEN_218 : {{3'd0}, mepc}; // @[src/main/scala/mini/CSR.scala 186:17 268:19]
  assign io__out = _io_out_T_1 ? cycle : _io_out_T_85; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  assign io__expt = _io_expt_T_14 | isEcall | isEbreak; // @[src/main/scala/mini/CSR.scala 255:41]
  assign io__evec = 32'h100 + _GEN_260; // @[src/main/scala/mini/CSR.scala 256:20]
  assign io__epc = mepc; // @[src/main/scala/mini/CSR.scala 257:10]
  assign io__host_tohost = mtohost; // @[src/main/scala/mini/CSR.scala 193:18]
  assign io_expt = io__expt;
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/mini/CSR.scala 129:21]
      time_ <= 32'h0; // @[src/main/scala/mini/CSR.scala 129:21]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (io__expt) begin // @[src/main/scala/mini/CSR.scala 271:19]
        time_ <= _time_T_1; // @[src/main/scala/mini/CSR.scala 260:8]
      end else if (isEret) begin // @[src/main/scala/mini/CSR.scala 291:24]
        time_ <= _time_T_1; // @[src/main/scala/mini/CSR.scala 260:8]
      end else begin
        time_ <= _GEN_184;
      end
    end else begin
      time_ <= _time_T_1; // @[src/main/scala/mini/CSR.scala 260:8]
    end
    if (reset) begin // @[src/main/scala/mini/CSR.scala 130:22]
      timeh <= 32'h0; // @[src/main/scala/mini/CSR.scala 130:22]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (io__expt) begin // @[src/main/scala/mini/CSR.scala 271:19]
        timeh <= _GEN_1;
      end else if (isEret) begin // @[src/main/scala/mini/CSR.scala 291:24]
        timeh <= _GEN_1;
      end else begin
        timeh <= _GEN_185;
      end
    end else begin
      timeh <= _GEN_1;
    end
    if (reset) begin // @[src/main/scala/mini/CSR.scala 131:22]
      cycle <= 32'h0; // @[src/main/scala/mini/CSR.scala 131:22]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (io__expt) begin // @[src/main/scala/mini/CSR.scala 271:19]
        cycle <= _cycle_T_1; // @[src/main/scala/mini/CSR.scala 262:9]
      end else if (isEret) begin // @[src/main/scala/mini/CSR.scala 291:24]
        cycle <= _cycle_T_1; // @[src/main/scala/mini/CSR.scala 262:9]
      end else begin
        cycle <= _GEN_193;
      end
    end else begin
      cycle <= _cycle_T_1; // @[src/main/scala/mini/CSR.scala 262:9]
    end
    if (reset) begin // @[src/main/scala/mini/CSR.scala 132:23]
      cycleh <= 32'h0; // @[src/main/scala/mini/CSR.scala 132:23]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (io__expt) begin // @[src/main/scala/mini/CSR.scala 271:19]
        cycleh <= _GEN_2;
      end else if (isEret) begin // @[src/main/scala/mini/CSR.scala 291:24]
        cycleh <= _GEN_2;
      end else begin
        cycleh <= _GEN_195;
      end
    end else begin
      cycleh <= _GEN_2;
    end
    if (reset) begin // @[src/main/scala/mini/CSR.scala 133:24]
      instret <= 32'h0; // @[src/main/scala/mini/CSR.scala 133:24]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (io__expt) begin // @[src/main/scala/mini/CSR.scala 271:19]
        instret <= _GEN_3;
      end else if (isEret) begin // @[src/main/scala/mini/CSR.scala 291:24]
        instret <= _GEN_3;
      end else begin
        instret <= _GEN_194;
      end
    end else begin
      instret <= _GEN_3;
    end
    if (reset) begin // @[src/main/scala/mini/CSR.scala 134:25]
      instreth <= 32'h0; // @[src/main/scala/mini/CSR.scala 134:25]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (io__expt) begin // @[src/main/scala/mini/CSR.scala 271:19]
        instreth <= _GEN_4;
      end else if (isEret) begin // @[src/main/scala/mini/CSR.scala 291:24]
        instreth <= _GEN_4;
      end else begin
        instreth <= _GEN_196;
      end
    end else begin
      instreth <= _GEN_4;
    end
    if (reset) begin // @[src/main/scala/mini/CSR.scala 146:20]
      PRV <= 2'h3; // @[src/main/scala/mini/CSR.scala 146:20]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (io__expt) begin // @[src/main/scala/mini/CSR.scala 271:19]
        PRV <= 2'h3; // @[src/main/scala/mini/CSR.scala 286:11]
      end else if (isEret) begin // @[src/main/scala/mini/CSR.scala 291:24]
        PRV <= PRV1; // @[src/main/scala/mini/CSR.scala 292:11]
      end else begin
        PRV <= _GEN_178;
      end
    end
    if (reset) begin // @[src/main/scala/mini/CSR.scala 147:21]
      PRV1 <= 2'h3; // @[src/main/scala/mini/CSR.scala 147:21]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (io__expt) begin // @[src/main/scala/mini/CSR.scala 271:19]
        PRV1 <= PRV; // @[src/main/scala/mini/CSR.scala 288:12]
      end else if (isEret) begin // @[src/main/scala/mini/CSR.scala 291:24]
        PRV1 <= 2'h0; // @[src/main/scala/mini/CSR.scala 294:12]
      end else begin
        PRV1 <= _GEN_176;
      end
    end
    if (reset) begin // @[src/main/scala/mini/CSR.scala 150:19]
      IE <= 1'h0; // @[src/main/scala/mini/CSR.scala 150:19]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (io__expt) begin // @[src/main/scala/mini/CSR.scala 271:19]
        IE <= 1'h0; // @[src/main/scala/mini/CSR.scala 287:10]
      end else if (isEret) begin // @[src/main/scala/mini/CSR.scala 291:24]
        IE <= IE1; // @[src/main/scala/mini/CSR.scala 293:10]
      end else begin
        IE <= _GEN_179;
      end
    end
    if (reset) begin // @[src/main/scala/mini/CSR.scala 151:20]
      IE1 <= 1'h0; // @[src/main/scala/mini/CSR.scala 151:20]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (io__expt) begin // @[src/main/scala/mini/CSR.scala 271:19]
        IE1 <= IE; // @[src/main/scala/mini/CSR.scala 289:11]
      end else begin
        IE1 <= _GEN_200;
      end
    end
    if (reset) begin // @[src/main/scala/mini/CSR.scala 167:21]
      MTIP <= 1'h0; // @[src/main/scala/mini/CSR.scala 167:21]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (!(io__expt)) begin // @[src/main/scala/mini/CSR.scala 271:19]
        if (!(isEret)) begin // @[src/main/scala/mini/CSR.scala 291:24]
          MTIP <= _GEN_180;
        end
      end
    end
    if (reset) begin // @[src/main/scala/mini/CSR.scala 170:21]
      MTIE <= 1'h0; // @[src/main/scala/mini/CSR.scala 170:21]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (!(io__expt)) begin // @[src/main/scala/mini/CSR.scala 271:19]
        if (!(isEret)) begin // @[src/main/scala/mini/CSR.scala 291:24]
          MTIE <= _GEN_182;
        end
      end
    end
    if (reset) begin // @[src/main/scala/mini/CSR.scala 173:21]
      MSIP <= 1'h0; // @[src/main/scala/mini/CSR.scala 173:21]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (!(io__expt)) begin // @[src/main/scala/mini/CSR.scala 271:19]
        if (!(isEret)) begin // @[src/main/scala/mini/CSR.scala 291:24]
          MSIP <= _GEN_181;
        end
      end
    end
    if (reset) begin // @[src/main/scala/mini/CSR.scala 176:21]
      MSIE <= 1'h0; // @[src/main/scala/mini/CSR.scala 176:21]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (!(io__expt)) begin // @[src/main/scala/mini/CSR.scala 271:19]
        if (!(isEret)) begin // @[src/main/scala/mini/CSR.scala 291:24]
          MSIE <= _GEN_183;
        end
      end
    end
    if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (!(io__expt)) begin // @[src/main/scala/mini/CSR.scala 271:19]
        if (!(isEret)) begin // @[src/main/scala/mini/CSR.scala 291:24]
          if (wen) begin // @[src/main/scala/mini/CSR.scala 296:21]
            mtimecmp <= _GEN_165;
          end
        end
      end
    end
    if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (!(io__expt)) begin // @[src/main/scala/mini/CSR.scala 271:19]
        if (!(isEret)) begin // @[src/main/scala/mini/CSR.scala 291:24]
          if (wen) begin // @[src/main/scala/mini/CSR.scala 296:21]
            mscratch <= _GEN_166;
          end
        end
      end
    end
    mepc <= _GEN_239[31:0];
    if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (io__expt) begin // @[src/main/scala/mini/CSR.scala 271:19]
        mcause <= {{28'd0}, _mcause_T_6}; // @[src/main/scala/mini/CSR.scala 273:14]
      end else if (!(isEret)) begin // @[src/main/scala/mini/CSR.scala 291:24]
        if (wen) begin // @[src/main/scala/mini/CSR.scala 296:21]
          mcause <= _GEN_168;
        end
      end
    end
    if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (io__expt) begin // @[src/main/scala/mini/CSR.scala 271:19]
        if (iaddrInvalid | laddrInvalid | saddrInvalid) begin // @[src/main/scala/mini/CSR.scala 290:58]
          mbadaddr <= io__addr; // @[src/main/scala/mini/CSR.scala 290:69]
        end
      end else if (!(isEret)) begin // @[src/main/scala/mini/CSR.scala 291:24]
        if (wen) begin // @[src/main/scala/mini/CSR.scala 296:21]
          mbadaddr <= _GEN_169;
        end
      end
    end
    if (reset) begin // @[src/main/scala/mini/CSR.scala 191:24]
      mtohost <= 32'h0; // @[src/main/scala/mini/CSR.scala 191:24]
    end else if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (!(io__expt)) begin // @[src/main/scala/mini/CSR.scala 271:19]
        if (!(isEret)) begin // @[src/main/scala/mini/CSR.scala 291:24]
          mtohost <= _GEN_191;
        end
      end
    end
    if (_isInstRet_T_5) begin // @[src/main/scala/mini/CSR.scala 268:19]
      if (io__expt) begin // @[src/main/scala/mini/CSR.scala 271:19]
        mfromhost <= _GEN_0;
      end else if (isEret) begin // @[src/main/scala/mini/CSR.scala 291:24]
        mfromhost <= _GEN_0;
      end else if (wen) begin // @[src/main/scala/mini/CSR.scala 296:21]
        mfromhost <= _GEN_171;
      end else begin
        mfromhost <= _GEN_0;
      end
    end else begin
      mfromhost <= _GEN_0;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_isInstRet_T_5 & ~reset) begin
          $fwrite(32'h80000002,"Exception:%d\n",io__expt); // @[src/main/scala/mini/CSR.scala 269:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  time_ = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  timeh = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  cycle = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  cycleh = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  instret = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  instreth = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  PRV = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  PRV1 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  IE = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  IE1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  MTIP = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  MTIE = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  MSIP = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  MSIE = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  mtimecmp = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  mscratch = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  mepc = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  mcause = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  mbadaddr = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  mtohost = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  mfromhost = _RAND_20[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RegFile(
  input         clock,
  input  [4:0]  io_raddr1, // @[src/main/scala/mini/RegFile.scala 18:14]
  input  [4:0]  io_raddr2, // @[src/main/scala/mini/RegFile.scala 18:14]
  output [31:0] io_rdata1, // @[src/main/scala/mini/RegFile.scala 18:14]
  output [31:0] io_rdata2, // @[src/main/scala/mini/RegFile.scala 18:14]
  input         io_wen, // @[src/main/scala/mini/RegFile.scala 18:14]
  input  [4:0]  io_waddr, // @[src/main/scala/mini/RegFile.scala 18:14]
  input  [31:0] io_wdata // @[src/main/scala/mini/RegFile.scala 18:14]
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] regs [0:31]; // @[src/main/scala/mini/RegFile.scala 19:16]
  wire  regs_io_rdata1_MPORT_en; // @[src/main/scala/mini/RegFile.scala 19:16]
  wire [4:0] regs_io_rdata1_MPORT_addr; // @[src/main/scala/mini/RegFile.scala 19:16]
  wire [31:0] regs_io_rdata1_MPORT_data; // @[src/main/scala/mini/RegFile.scala 19:16]
  wire  regs_io_rdata2_MPORT_en; // @[src/main/scala/mini/RegFile.scala 19:16]
  wire [4:0] regs_io_rdata2_MPORT_addr; // @[src/main/scala/mini/RegFile.scala 19:16]
  wire [31:0] regs_io_rdata2_MPORT_data; // @[src/main/scala/mini/RegFile.scala 19:16]
  wire [31:0] regs_MPORT_data; // @[src/main/scala/mini/RegFile.scala 19:16]
  wire [4:0] regs_MPORT_addr; // @[src/main/scala/mini/RegFile.scala 19:16]
  wire  regs_MPORT_mask; // @[src/main/scala/mini/RegFile.scala 19:16]
  wire  regs_MPORT_en; // @[src/main/scala/mini/RegFile.scala 19:16]
  wire  _T = |io_waddr; // @[src/main/scala/mini/RegFile.scala 23:26]
  assign regs_io_rdata1_MPORT_en = 1'h1;
  assign regs_io_rdata1_MPORT_addr = io_raddr1;
  assign regs_io_rdata1_MPORT_data = regs[regs_io_rdata1_MPORT_addr]; // @[src/main/scala/mini/RegFile.scala 19:16]
  assign regs_io_rdata2_MPORT_en = 1'h1;
  assign regs_io_rdata2_MPORT_addr = io_raddr2;
  assign regs_io_rdata2_MPORT_data = regs[regs_io_rdata2_MPORT_addr]; // @[src/main/scala/mini/RegFile.scala 19:16]
  assign regs_MPORT_data = io_wdata;
  assign regs_MPORT_addr = io_waddr;
  assign regs_MPORT_mask = 1'h1;
  assign regs_MPORT_en = io_wen & _T;
  assign io_rdata1 = |io_raddr1 ? regs_io_rdata1_MPORT_data : 32'h0; // @[src/main/scala/mini/RegFile.scala 21:19]
  assign io_rdata2 = |io_raddr2 ? regs_io_rdata2_MPORT_data : 32'h0; // @[src/main/scala/mini/RegFile.scala 22:19]
  always @(posedge clock) begin
    if (regs_MPORT_en & regs_MPORT_mask) begin
      regs[regs_MPORT_addr] <= regs_MPORT_data; // @[src/main/scala/mini/RegFile.scala 19:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regs[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AluArea(
  input  [31:0] io_A, // @[src/main/scala/mini/Alu.scala 65:14]
  input  [31:0] io_B, // @[src/main/scala/mini/Alu.scala 65:14]
  input  [3:0]  io_alu_op, // @[src/main/scala/mini/Alu.scala 65:14]
  output [31:0] io_out, // @[src/main/scala/mini/Alu.scala 65:14]
  output [31:0] io_sum // @[src/main/scala/mini/Alu.scala 65:14]
);
  wire [31:0] _sum_T_2 = 32'h0 - io_B; // @[src/main/scala/mini/Alu.scala 66:38]
  wire [31:0] _sum_T_3 = io_alu_op[0] ? _sum_T_2 : io_B; // @[src/main/scala/mini/Alu.scala 66:23]
  wire [31:0] sum = io_A + _sum_T_3; // @[src/main/scala/mini/Alu.scala 66:18]
  wire  _cmp_T_7 = io_alu_op[1] ? io_B[31] : io_A[31]; // @[src/main/scala/mini/Alu.scala 68:65]
  wire  cmp = io_A[31] == io_B[31] ? sum[31] : _cmp_T_7; // @[src/main/scala/mini/Alu.scala 68:8]
  wire [4:0] shamt = io_B[4:0]; // @[src/main/scala/mini/Alu.scala 69:19]
  wire [31:0] _GEN_0 = {{16'd0}, io_A[31:16]}; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_4 = _GEN_0 & 32'hffff; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_6 = {io_A[15:0], 16'h0}; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_8 = _shin_T_6 & 32'hffff0000; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_9 = _shin_T_4 | _shin_T_8; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _GEN_1 = {{8'd0}, _shin_T_9[31:8]}; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_14 = _GEN_1 & 32'hff00ff; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_16 = {_shin_T_9[23:0], 8'h0}; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_18 = _shin_T_16 & 32'hff00ff00; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_19 = _shin_T_14 | _shin_T_18; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _GEN_2 = {{4'd0}, _shin_T_19[31:4]}; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_24 = _GEN_2 & 32'hf0f0f0f; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_26 = {_shin_T_19[27:0], 4'h0}; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_28 = _shin_T_26 & 32'hf0f0f0f0; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_29 = _shin_T_24 | _shin_T_28; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _GEN_3 = {{2'd0}, _shin_T_29[31:2]}; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_34 = _GEN_3 & 32'h33333333; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_36 = {_shin_T_29[29:0], 2'h0}; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_38 = _shin_T_36 & 32'hcccccccc; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_39 = _shin_T_34 | _shin_T_38; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _GEN_4 = {{1'd0}, _shin_T_39[31:1]}; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_44 = _GEN_4 & 32'h55555555; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_46 = {_shin_T_39[30:0], 1'h0}; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_48 = _shin_T_46 & 32'haaaaaaaa; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] _shin_T_49 = _shin_T_44 | _shin_T_48; // @[src/main/scala/mini/Alu.scala 70:45]
  wire [31:0] shin = io_alu_op[3] ? io_A : _shin_T_49; // @[src/main/scala/mini/Alu.scala 70:17]
  wire  _shiftr_T_2 = io_alu_op[0] & shin[31]; // @[src/main/scala/mini/Alu.scala 71:34]
  wire [32:0] _shiftr_T_4 = {_shiftr_T_2,shin}; // @[src/main/scala/mini/Alu.scala 71:60]
  wire [32:0] _shiftr_T_5 = $signed(_shiftr_T_4) >>> shamt; // @[src/main/scala/mini/Alu.scala 71:67]
  wire [31:0] shiftr = _shiftr_T_5[31:0]; // @[src/main/scala/mini/Alu.scala 71:76]
  wire [31:0] _GEN_5 = {{16'd0}, shiftr[31:16]}; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_3 = _GEN_5 & 32'hffff; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_5 = {shiftr[15:0], 16'h0}; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_7 = _shiftl_T_5 & 32'hffff0000; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_8 = _shiftl_T_3 | _shiftl_T_7; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _GEN_6 = {{8'd0}, _shiftl_T_8[31:8]}; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_13 = _GEN_6 & 32'hff00ff; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_15 = {_shiftl_T_8[23:0], 8'h0}; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_17 = _shiftl_T_15 & 32'hff00ff00; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_18 = _shiftl_T_13 | _shiftl_T_17; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _GEN_7 = {{4'd0}, _shiftl_T_18[31:4]}; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_23 = _GEN_7 & 32'hf0f0f0f; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_25 = {_shiftl_T_18[27:0], 4'h0}; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_27 = _shiftl_T_25 & 32'hf0f0f0f0; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_28 = _shiftl_T_23 | _shiftl_T_27; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _GEN_8 = {{2'd0}, _shiftl_T_28[31:2]}; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_33 = _GEN_8 & 32'h33333333; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_35 = {_shiftl_T_28[29:0], 2'h0}; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_37 = _shiftl_T_35 & 32'hcccccccc; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_38 = _shiftl_T_33 | _shiftl_T_37; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _GEN_9 = {{1'd0}, _shiftl_T_38[31:1]}; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_43 = _GEN_9 & 32'h55555555; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_45 = {_shiftl_T_38[30:0], 1'h0}; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] _shiftl_T_47 = _shiftl_T_45 & 32'haaaaaaaa; // @[src/main/scala/mini/Alu.scala 72:23]
  wire [31:0] shiftl = _shiftl_T_43 | _shiftl_T_47; // @[src/main/scala/mini/Alu.scala 72:23]
  wire  _out_T_3 = io_alu_op == 4'hc; // @[src/main/scala/mini/Alu.scala 76:67]
  wire  _out_T_4 = io_alu_op == 4'h0 | io_alu_op == 4'h1 | io_alu_op == 4'hc; // @[src/main/scala/mini/Alu.scala 76:54]
  wire [31:0] _out_T_7 = {sum[31:1],1'h0}; // @[src/main/scala/mini/Alu.scala 77:38]
  wire [31:0] _out_T_8 = _out_T_3 ? _out_T_7 : sum; // @[src/main/scala/mini/Alu.scala 77:10]
  wire  _out_T_11 = io_alu_op == 4'h5 | io_alu_op == 4'h7; // @[src/main/scala/mini/Alu.scala 79:31]
  wire  _out_T_14 = io_alu_op == 4'h9 | io_alu_op == 4'h8; // @[src/main/scala/mini/Alu.scala 82:33]
  wire  _out_T_15 = io_alu_op == 4'h6; // @[src/main/scala/mini/Alu.scala 85:23]
  wire  _out_T_16 = io_alu_op == 4'h2; // @[src/main/scala/mini/Alu.scala 88:25]
  wire [31:0] _out_T_17 = io_A & io_B; // @[src/main/scala/mini/Alu.scala 89:20]
  wire  _out_T_18 = io_alu_op == 4'h3; // @[src/main/scala/mini/Alu.scala 91:27]
  wire [31:0] _out_T_19 = io_A | io_B; // @[src/main/scala/mini/Alu.scala 92:22]
  wire [31:0] _out_T_21 = io_A ^ io_B; // @[src/main/scala/mini/Alu.scala 93:49]
  wire [31:0] _out_T_23 = io_alu_op == 4'ha ? io_A : io_B; // @[src/main/scala/mini/Alu.scala 93:60]
  wire [31:0] _out_T_24 = io_alu_op == 4'h4 ? _out_T_21 : _out_T_23; // @[src/main/scala/mini/Alu.scala 93:20]
  wire [31:0] _out_T_25 = _out_T_18 ? _out_T_19 : _out_T_24; // @[src/main/scala/mini/Alu.scala 90:18]
  wire [31:0] _out_T_26 = _out_T_16 ? _out_T_17 : _out_T_25; // @[src/main/scala/mini/Alu.scala 87:16]
  wire [31:0] _out_T_27 = _out_T_15 ? shiftl : _out_T_26; // @[src/main/scala/mini/Alu.scala 84:14]
  wire [31:0] _out_T_28 = _out_T_14 ? shiftr : _out_T_27; // @[src/main/scala/mini/Alu.scala 81:12]
  wire [31:0] _out_T_29 = _out_T_11 ? {{31'd0}, cmp} : _out_T_28; // @[src/main/scala/mini/Alu.scala 78:10]
  assign io_out = _out_T_4 ? _out_T_8 : _out_T_29; // @[src/main/scala/mini/Alu.scala 75:8]
  assign io_sum = io_A + _sum_T_3; // @[src/main/scala/mini/Alu.scala 66:18]
endmodule
module ImmGenWire(
  input  [31:0] io_inst, // @[src/main/scala/mini/ImmGen.scala 21:14]
  input  [2:0]  io_sel, // @[src/main/scala/mini/ImmGen.scala 21:14]
  output [31:0] io_out // @[src/main/scala/mini/ImmGen.scala 21:14]
);
  wire [11:0] Iimm = io_inst[31:20]; // @[src/main/scala/mini/ImmGen.scala 22:30]
  wire [11:0] Simm = {io_inst[31:25],io_inst[11:7]}; // @[src/main/scala/mini/ImmGen.scala 23:51]
  wire [12:0] Bimm = {io_inst[31],io_inst[7],io_inst[30:25],io_inst[11:8],1'h0}; // @[src/main/scala/mini/ImmGen.scala 24:86]
  wire [31:0] Uimm = {io_inst[31:12],12'h0}; // @[src/main/scala/mini/ImmGen.scala 25:46]
  wire [20:0] Jimm = {io_inst[31],io_inst[19:12],io_inst[20],io_inst[30:25],io_inst[24:21],1'h0}; // @[src/main/scala/mini/ImmGen.scala 26:105]
  wire [5:0] Zimm = {1'b0,$signed(io_inst[19:15])}; // @[src/main/scala/mini/ImmGen.scala 27:30]
  wire [11:0] _io_out_T_1 = $signed(Iimm) & -12'sh2; // @[src/main/scala/mini/ImmGen.scala 29:36]
  wire [11:0] _io_out_T_3 = 3'h1 == io_sel ? $signed(Iimm) : $signed(_io_out_T_1); // @[src/main/scala/mini/ImmGen.scala 29:45]
  wire [11:0] _io_out_T_5 = 3'h2 == io_sel ? $signed(Simm) : $signed(_io_out_T_3); // @[src/main/scala/mini/ImmGen.scala 29:45]
  wire [12:0] _io_out_T_7 = 3'h5 == io_sel ? $signed(Bimm) : $signed({{1{_io_out_T_5[11]}},_io_out_T_5}); // @[src/main/scala/mini/ImmGen.scala 29:45]
  wire [31:0] _io_out_T_9 = 3'h3 == io_sel ? $signed(Uimm) : $signed({{19{_io_out_T_7[12]}},_io_out_T_7}); // @[src/main/scala/mini/ImmGen.scala 29:45]
  wire [31:0] _io_out_T_11 = 3'h4 == io_sel ? $signed({{11{Jimm[20]}},Jimm}) : $signed(_io_out_T_9); // @[src/main/scala/mini/ImmGen.scala 29:45]
  assign io_out = 3'h6 == io_sel ? $signed({{26{Zimm[5]}},Zimm}) : $signed(_io_out_T_11); // @[src/main/scala/mini/ImmGen.scala 31:5]
endmodule
module BrCondArea(
  input  [31:0] io_rs1, // @[src/main/scala/mini/BrCond.scala 38:14]
  input  [31:0] io_rs2, // @[src/main/scala/mini/BrCond.scala 38:14]
  input  [2:0]  io_br_type, // @[src/main/scala/mini/BrCond.scala 38:14]
  output        io_taken // @[src/main/scala/mini/BrCond.scala 38:14]
);
  wire [31:0] diff = io_rs1 - io_rs2; // @[src/main/scala/mini/BrCond.scala 39:21]
  wire  neq = |diff; // @[src/main/scala/mini/BrCond.scala 40:18]
  wire  eq = ~neq; // @[src/main/scala/mini/BrCond.scala 41:12]
  wire  isSameSign = io_rs1[31] == io_rs2[31]; // @[src/main/scala/mini/BrCond.scala 42:37]
  wire  lt = isSameSign ? diff[31] : io_rs1[31]; // @[src/main/scala/mini/BrCond.scala 43:15]
  wire  ltu = isSameSign ? diff[31] : io_rs2[31]; // @[src/main/scala/mini/BrCond.scala 44:16]
  wire  ge = ~lt; // @[src/main/scala/mini/BrCond.scala 45:12]
  wire  geu = ~ltu; // @[src/main/scala/mini/BrCond.scala 46:13]
  wire  _io_taken_T_3 = io_br_type == 3'h6 & neq; // @[src/main/scala/mini/BrCond.scala 49:31]
  wire  _io_taken_T_4 = io_br_type == 3'h3 & eq | _io_taken_T_3; // @[src/main/scala/mini/BrCond.scala 48:36]
  wire  _io_taken_T_6 = io_br_type == 3'h2 & lt; // @[src/main/scala/mini/BrCond.scala 50:31]
  wire  _io_taken_T_7 = _io_taken_T_4 | _io_taken_T_6; // @[src/main/scala/mini/BrCond.scala 49:39]
  wire  _io_taken_T_9 = io_br_type == 3'h5 & ge; // @[src/main/scala/mini/BrCond.scala 51:31]
  wire  _io_taken_T_10 = _io_taken_T_7 | _io_taken_T_9; // @[src/main/scala/mini/BrCond.scala 50:38]
  wire  _io_taken_T_12 = io_br_type == 3'h1 & ltu; // @[src/main/scala/mini/BrCond.scala 52:32]
  wire  _io_taken_T_13 = _io_taken_T_10 | _io_taken_T_12; // @[src/main/scala/mini/BrCond.scala 51:38]
  wire  _io_taken_T_15 = io_br_type == 3'h4 & geu; // @[src/main/scala/mini/BrCond.scala 53:32]
  assign io_taken = _io_taken_T_13 | _io_taken_T_15; // @[src/main/scala/mini/BrCond.scala 52:40]
endmodule
module Datapath(
  input         clock,
  input         reset,
  input         io__host_fromhost_valid, // @[src/main/scala/mini/Datapath.scala 35:14]
  input  [31:0] io__host_fromhost_bits, // @[src/main/scala/mini/Datapath.scala 35:14]
  output [31:0] io__host_tohost, // @[src/main/scala/mini/Datapath.scala 35:14]
  output        io__icache_req_valid, // @[src/main/scala/mini/Datapath.scala 35:14]
  output [31:0] io__icache_req_bits_addr, // @[src/main/scala/mini/Datapath.scala 35:14]
  input         io__icache_resp_valid, // @[src/main/scala/mini/Datapath.scala 35:14]
  input  [31:0] io__icache_resp_bits_data, // @[src/main/scala/mini/Datapath.scala 35:14]
  output        io__dcache_abort, // @[src/main/scala/mini/Datapath.scala 35:14]
  output        io__dcache_req_valid, // @[src/main/scala/mini/Datapath.scala 35:14]
  output [31:0] io__dcache_req_bits_addr, // @[src/main/scala/mini/Datapath.scala 35:14]
  output [31:0] io__dcache_req_bits_data, // @[src/main/scala/mini/Datapath.scala 35:14]
  output [3:0]  io__dcache_req_bits_mask, // @[src/main/scala/mini/Datapath.scala 35:14]
  input         io__dcache_resp_valid, // @[src/main/scala/mini/Datapath.scala 35:14]
  input  [31:0] io__dcache_resp_bits_data, // @[src/main/scala/mini/Datapath.scala 35:14]
  output [31:0] io__ctrl_inst, // @[src/main/scala/mini/Datapath.scala 35:14]
  input  [1:0]  io__ctrl_pc_sel, // @[src/main/scala/mini/Datapath.scala 35:14]
  input         io__ctrl_inst_kill, // @[src/main/scala/mini/Datapath.scala 35:14]
  input         io__ctrl_A_sel, // @[src/main/scala/mini/Datapath.scala 35:14]
  input         io__ctrl_B_sel, // @[src/main/scala/mini/Datapath.scala 35:14]
  input  [2:0]  io__ctrl_imm_sel, // @[src/main/scala/mini/Datapath.scala 35:14]
  input  [3:0]  io__ctrl_alu_op, // @[src/main/scala/mini/Datapath.scala 35:14]
  input  [2:0]  io__ctrl_br_type, // @[src/main/scala/mini/Datapath.scala 35:14]
  input  [1:0]  io__ctrl_st_type, // @[src/main/scala/mini/Datapath.scala 35:14]
  input  [2:0]  io__ctrl_ld_type, // @[src/main/scala/mini/Datapath.scala 35:14]
  input  [1:0]  io__ctrl_wb_sel, // @[src/main/scala/mini/Datapath.scala 35:14]
  input         io__ctrl_wb_en, // @[src/main/scala/mini/Datapath.scala 35:14]
  input  [2:0]  io__ctrl_csr_cmd, // @[src/main/scala/mini/Datapath.scala 35:14]
  input         io__ctrl_illegal, // @[src/main/scala/mini/Datapath.scala 35:14]
  output [4:0]  _T_18_0,
  output [32:0] _T_9_0,
  output [31:0] REG_4_0,
  output        io_expt,
  output [31:0] ew_reg_inst,
  output [34:0] REG_6_0,
  output [4:0]  flywire_rs2_addr_0,
  output [31:0] ew_reg_pc,
  output        _T_8_0,
  output [63:0] instOrder_0,
  output [31:0] io_dcache_resp_bits_data,
  output [4:0]  load_mask_0,
  output [31:0] REG_3_0,
  output [4:0]  flywire_rs1_addr_0,
  output        instCommit_0,
  output [31:0] REG_5_0,
  output [32:0] regWrite_0,
  output [3:0]  REG_2_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [63:0] _RAND_30;
`endif // RANDOMIZE_REG_INIT
  wire  csr_clock; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire  csr_reset; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire  csr_io__stall; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire [2:0] csr_io__cmd; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire [31:0] csr_io__in; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire [31:0] csr_io__out; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire [31:0] csr_io__pc; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire [31:0] csr_io__addr; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire [31:0] csr_io__inst; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire  csr_io__illegal; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire [1:0] csr_io__st_type; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire [2:0] csr_io__ld_type; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire  csr_io__pc_check; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire  csr_io__expt; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire [31:0] csr_io__evec; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire [31:0] csr_io__epc; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire  csr_io__host_fromhost_valid; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire [31:0] csr_io__host_fromhost_bits; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire [31:0] csr_io__host_tohost; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire  csr_io_expt; // @[src/main/scala/mini/Datapath.scala 36:19]
  wire  regFile_clock; // @[src/main/scala/mini/Datapath.scala 37:23]
  wire [4:0] regFile_io_raddr1; // @[src/main/scala/mini/Datapath.scala 37:23]
  wire [4:0] regFile_io_raddr2; // @[src/main/scala/mini/Datapath.scala 37:23]
  wire [31:0] regFile_io_rdata1; // @[src/main/scala/mini/Datapath.scala 37:23]
  wire [31:0] regFile_io_rdata2; // @[src/main/scala/mini/Datapath.scala 37:23]
  wire  regFile_io_wen; // @[src/main/scala/mini/Datapath.scala 37:23]
  wire [4:0] regFile_io_waddr; // @[src/main/scala/mini/Datapath.scala 37:23]
  wire [31:0] regFile_io_wdata; // @[src/main/scala/mini/Datapath.scala 37:23]
  wire [31:0] alu_io_A; // @[src/main/scala/mini/Datapath.scala 38:19]
  wire [31:0] alu_io_B; // @[src/main/scala/mini/Datapath.scala 38:19]
  wire [3:0] alu_io_alu_op; // @[src/main/scala/mini/Datapath.scala 38:19]
  wire [31:0] alu_io_out; // @[src/main/scala/mini/Datapath.scala 38:19]
  wire [31:0] alu_io_sum; // @[src/main/scala/mini/Datapath.scala 38:19]
  wire [31:0] immGen_io_inst; // @[src/main/scala/mini/Datapath.scala 39:22]
  wire [2:0] immGen_io_sel; // @[src/main/scala/mini/Datapath.scala 39:22]
  wire [31:0] immGen_io_out; // @[src/main/scala/mini/Datapath.scala 39:22]
  wire [31:0] brCond_io_rs1; // @[src/main/scala/mini/Datapath.scala 40:22]
  wire [31:0] brCond_io_rs2; // @[src/main/scala/mini/Datapath.scala 40:22]
  wire [2:0] brCond_io_br_type; // @[src/main/scala/mini/Datapath.scala 40:22]
  wire  brCond_io_taken; // @[src/main/scala/mini/Datapath.scala 40:22]
  reg [31:0] fe_reg_inst; // @[src/main/scala/mini/Datapath.scala 48:23]
  reg [31:0] fe_reg_pc; // @[src/main/scala/mini/Datapath.scala 48:23]
  reg [31:0] ew_reg__inst; // @[src/main/scala/mini/Datapath.scala 57:23]
  reg [31:0] ew_reg__pc; // @[src/main/scala/mini/Datapath.scala 57:23]
  reg [31:0] ew_reg__alu; // @[src/main/scala/mini/Datapath.scala 57:23]
  reg [31:0] ew_reg__csr_in; // @[src/main/scala/mini/Datapath.scala 57:23]
  reg [1:0] st_type; // @[src/main/scala/mini/Datapath.scala 68:20]
  reg [2:0] ld_type; // @[src/main/scala/mini/Datapath.scala 69:20]
  reg [1:0] wb_sel; // @[src/main/scala/mini/Datapath.scala 70:19]
  reg  wb_en; // @[src/main/scala/mini/Datapath.scala 71:18]
  reg [2:0] csr_cmd; // @[src/main/scala/mini/Datapath.scala 72:20]
  reg  illegal; // @[src/main/scala/mini/Datapath.scala 73:20]
  reg  pc_check; // @[src/main/scala/mini/Datapath.scala 74:21]
  reg  started; // @[src/main/scala/mini/Datapath.scala 78:24]
  wire  stall = ~io__icache_resp_valid | ~io__dcache_resp_valid; // @[src/main/scala/mini/Datapath.scala 79:37]
  wire [31:0] _pc_T_1 = 32'h200 - 32'h4; // @[src/main/scala/mini/Datapath.scala 80:50]
  reg [32:0] pc; // @[src/main/scala/mini/Datapath.scala 80:19]
  wire [32:0] _next_pc_T_1 = pc + 33'h4; // @[src/main/scala/mini/Datapath.scala 83:8]
  wire  _next_pc_T_2 = io__ctrl_pc_sel == 2'h3; // @[src/main/scala/mini/Datapath.scala 87:23]
  wire  _next_pc_T_3 = io__ctrl_pc_sel == 2'h1; // @[src/main/scala/mini/Datapath.scala 88:24]
  wire  _next_pc_T_4 = io__ctrl_pc_sel == 2'h1 | brCond_io_taken; // @[src/main/scala/mini/Datapath.scala 88:36]
  wire [31:0] _next_pc_T_5 = {{1'd0}, alu_io_sum[31:1]}; // @[src/main/scala/mini/Datapath.scala 88:73]
  wire [32:0] _next_pc_T_6 = {_next_pc_T_5, 1'h0}; // @[src/main/scala/mini/Datapath.scala 88:80]
  wire  _next_pc_T_7 = io__ctrl_pc_sel == 2'h2; // @[src/main/scala/mini/Datapath.scala 89:23]
  wire [32:0] _next_pc_T_8 = _next_pc_T_7 ? pc : _next_pc_T_1; // @[src/main/scala/chisel3/util/Mux.scala 141:16]
  wire [32:0] _next_pc_T_9 = _next_pc_T_4 ? _next_pc_T_6 : _next_pc_T_8; // @[src/main/scala/chisel3/util/Mux.scala 141:16]
  wire [32:0] _next_pc_T_10 = _next_pc_T_2 ? {{1'd0}, csr_io__epc} : _next_pc_T_9; // @[src/main/scala/chisel3/util/Mux.scala 141:16]
  wire [32:0] _next_pc_T_11 = csr_io__expt ? {{1'd0}, csr_io__evec} : _next_pc_T_10; // @[src/main/scala/chisel3/util/Mux.scala 141:16]
  wire [32:0] next_pc = stall ? pc : _next_pc_T_11; // @[src/main/scala/chisel3/util/Mux.scala 141:16]
  reg  REG; // @[src/main/scala/mini/Datapath.scala 92:58]
  wire  _T_8 = csr_io__expt | REG; // @[src/main/scala/mini/Datapath.scala 92:48]
  reg [32:0] REG_1; // @[src/main/scala/mini/Datapath.scala 93:58]
  wire [32:0] _T_9 = csr_io__expt ? next_pc : REG_1; // @[src/main/scala/mini/Datapath.scala 93:28]
  wire  _inst_T_2 = started | io__ctrl_inst_kill | brCond_io_taken | csr_io__expt; // @[src/main/scala/mini/Datapath.scala 96:57]
  wire  _io_icache_req_valid_T = ~stall; // @[src/main/scala/mini/Datapath.scala 103:26]
  wire [32:0] _GEN_0 = _io_icache_req_valid_T ? pc : {{1'd0}, fe_reg_pc}; // @[src/main/scala/mini/Datapath.scala 107:16 108:15 48:23]
  wire [4:0] rs1_addr = fe_reg_inst[19:15]; // @[src/main/scala/mini/Datapath.scala 118:29]
  wire [4:0] rs2_addr = fe_reg_inst[24:20]; // @[src/main/scala/mini/Datapath.scala 119:29]
  wire [4:0] wb_rd_addr = ew_reg__inst[11:7]; // @[src/main/scala/mini/Datapath.scala 128:31]
  wire  rs1hazard = wb_en & |rs1_addr & rs1_addr == wb_rd_addr; // @[src/main/scala/mini/Datapath.scala 129:41]
  wire  rs2hazard = wb_en & |rs2_addr & rs2_addr == wb_rd_addr; // @[src/main/scala/mini/Datapath.scala 130:41]
  wire  _rs1_T = wb_sel == 2'h0; // @[src/main/scala/mini/Datapath.scala 131:24]
  wire [31:0] rs1 = wb_sel == 2'h0 & rs1hazard ? ew_reg__alu : regFile_io_rdata1; // @[src/main/scala/mini/Datapath.scala 131:16]
  wire [31:0] rs2 = _rs1_T & rs2hazard ? ew_reg__alu : regFile_io_rdata2; // @[src/main/scala/mini/Datapath.scala 132:16]
  wire [31:0] _daddr_T = stall ? ew_reg__alu : alu_io_sum; // @[src/main/scala/mini/Datapath.scala 145:18]
  wire [31:0] _daddr_T_1 = {{2'd0}, _daddr_T[31:2]}; // @[src/main/scala/mini/Datapath.scala 145:50]
  wire [33:0] _GEN_27 = {_daddr_T_1, 2'h0}; // @[src/main/scala/mini/Datapath.scala 145:57]
  wire [34:0] daddr = {{1'd0}, _GEN_27}; // @[src/main/scala/mini/Datapath.scala 145:57]
  wire [4:0] _GEN_28 = {alu_io_sum[1], 4'h0}; // @[src/main/scala/mini/Datapath.scala 146:32]
  wire [7:0] _woffset_T_1 = {{3'd0}, _GEN_28}; // @[src/main/scala/mini/Datapath.scala 146:32]
  wire [3:0] _woffset_T_3 = {alu_io_sum[0], 3'h0}; // @[src/main/scala/mini/Datapath.scala 146:64]
  wire [7:0] _GEN_29 = {{4'd0}, _woffset_T_3}; // @[src/main/scala/mini/Datapath.scala 146:47]
  wire [7:0] woffset = _woffset_T_1 | _GEN_29; // @[src/main/scala/mini/Datapath.scala 146:47]
  wire [286:0] _GEN_13 = {{255'd0}, rs2}; // @[src/main/scala/mini/Datapath.scala 149:34]
  wire [286:0] _io_dcache_req_bits_data_T = _GEN_13 << woffset; // @[src/main/scala/mini/Datapath.scala 149:34]
  wire [1:0] _io_dcache_req_bits_mask_T = stall ? st_type : io__ctrl_st_type; // @[src/main/scala/mini/Datapath.scala 150:43]
  wire [4:0] _io_dcache_req_bits_mask_T_2 = 5'h3 << alu_io_sum[1:0]; // @[src/main/scala/mini/Datapath.scala 151:47]
  wire [3:0] _io_dcache_req_bits_mask_T_4 = 4'h1 << alu_io_sum[1:0]; // @[src/main/scala/mini/Datapath.scala 151:86]
  wire [3:0] _io_dcache_req_bits_mask_T_6 = 2'h1 == _io_dcache_req_bits_mask_T ? 4'hf : 4'h0; // @[src/main/scala/mini/Datapath.scala 150:88]
  wire [4:0] _io_dcache_req_bits_mask_T_8 = 2'h2 == _io_dcache_req_bits_mask_T ? _io_dcache_req_bits_mask_T_2 : {{1
    'd0}, _io_dcache_req_bits_mask_T_6}; // @[src/main/scala/mini/Datapath.scala 150:88]
  wire [4:0] _io_dcache_req_bits_mask_T_10 = 2'h3 == _io_dcache_req_bits_mask_T ? {{1'd0}, _io_dcache_req_bits_mask_T_4}
     : _io_dcache_req_bits_mask_T_8; // @[src/main/scala/mini/Datapath.scala 150:88]
  wire  _T_16 = ~csr_io__expt; // @[src/main/scala/mini/Datapath.scala 162:24]
  wire [4:0] _GEN_30 = {ew_reg__alu[1], 4'h0}; // @[src/main/scala/mini/Datapath.scala 177:32]
  wire [7:0] _loffset_T_1 = {{3'd0}, _GEN_30}; // @[src/main/scala/mini/Datapath.scala 177:32]
  wire [3:0] _loffset_T_3 = {ew_reg__alu[0], 3'h0}; // @[src/main/scala/mini/Datapath.scala 177:64]
  wire [7:0] _GEN_31 = {{4'd0}, _loffset_T_3}; // @[src/main/scala/mini/Datapath.scala 177:47]
  wire [7:0] loffset = _loffset_T_1 | _GEN_31; // @[src/main/scala/mini/Datapath.scala 177:47]
  wire [31:0] lshift = io__dcache_resp_bits_data >> loffset; // @[src/main/scala/mini/Datapath.scala 178:41]
  wire [32:0] _load_T = {1'b0,$signed(io__dcache_resp_bits_data)}; // @[src/main/scala/mini/Datapath.scala 179:58]
  wire [15:0] _load_T_2 = lshift[15:0]; // @[src/main/scala/mini/Datapath.scala 181:30]
  wire [7:0] _load_T_4 = lshift[7:0]; // @[src/main/scala/mini/Datapath.scala 182:29]
  wire [16:0] _load_T_6 = {1'b0,$signed(lshift[15:0])}; // @[src/main/scala/mini/Datapath.scala 183:31]
  wire [8:0] _load_T_8 = {1'b0,$signed(lshift[7:0])}; // @[src/main/scala/mini/Datapath.scala 184:30]
  wire  _load_T_9 = 3'h2 == ld_type; // @[src/main/scala/mini/Datapath.scala 179:63]
  wire [32:0] _load_T_10 = 3'h2 == ld_type ? $signed({{17{_load_T_2[15]}},_load_T_2}) : $signed(_load_T); // @[src/main/scala/mini/Datapath.scala 179:63]
  wire  _load_T_11 = 3'h3 == ld_type; // @[src/main/scala/mini/Datapath.scala 179:63]
  wire [32:0] _load_T_12 = 3'h3 == ld_type ? $signed({{25{_load_T_4[7]}},_load_T_4}) : $signed(_load_T_10); // @[src/main/scala/mini/Datapath.scala 179:63]
  wire  _load_T_13 = 3'h4 == ld_type; // @[src/main/scala/mini/Datapath.scala 179:63]
  wire [32:0] _load_T_14 = 3'h4 == ld_type ? $signed({{16{_load_T_6[16]}},_load_T_6}) : $signed(_load_T_12); // @[src/main/scala/mini/Datapath.scala 179:63]
  wire  _load_T_15 = 3'h5 == ld_type; // @[src/main/scala/mini/Datapath.scala 179:63]
  wire [32:0] load = 3'h5 == ld_type ? $signed({{24{_load_T_8[8]}},_load_T_8}) : $signed(_load_T_14); // @[src/main/scala/mini/Datapath.scala 179:63]
  reg [31:0] lw_addr; // @[src/main/scala/mini/Datapath.scala 191:24]
  wire [4:0] _load_mask_T_1 = 5'h3 << lw_addr[1:0]; // @[src/main/scala/mini/Datapath.scala 195:28]
  wire [3:0] _load_mask_T_3 = 4'h1 << lw_addr[1:0]; // @[src/main/scala/mini/Datapath.scala 196:28]
  wire [3:0] _load_mask_T_9 = 3'h0 == ld_type ? 4'h0 : 4'hf; // @[src/main/scala/mini/Datapath.scala 192:48]
  wire [4:0] _load_mask_T_11 = _load_T_9 ? _load_mask_T_1 : {{1'd0}, _load_mask_T_9}; // @[src/main/scala/mini/Datapath.scala 192:48]
  wire [4:0] _load_mask_T_13 = _load_T_11 ? {{1'd0}, _load_mask_T_3} : _load_mask_T_11; // @[src/main/scala/mini/Datapath.scala 192:48]
  wire [4:0] _load_mask_T_15 = _load_T_13 ? _load_mask_T_1 : _load_mask_T_13; // @[src/main/scala/mini/Datapath.scala 192:48]
  wire [4:0] load_mask = _load_T_15 ? {{1'd0}, _load_mask_T_3} : _load_mask_T_15; // @[src/main/scala/mini/Datapath.scala 192:48]
  reg [3:0] REG_2; // @[src/main/scala/mini/Datapath.scala 205:32]
  reg [31:0] REG_3; // @[src/main/scala/mini/Datapath.scala 206:32]
  wire [32:0] _regWrite_T = {1'b0,$signed(ew_reg__alu)}; // @[src/main/scala/mini/Datapath.scala 222:34]
  wire [31:0] _regWrite_T_2 = ew_reg__pc + 32'h4; // @[src/main/scala/mini/Datapath.scala 223:48]
  wire [32:0] _regWrite_T_3 = {1'b0,$signed(_regWrite_T_2)}; // @[src/main/scala/mini/Datapath.scala 223:55]
  wire [32:0] _regWrite_T_4 = {1'b0,$signed(csr_io__out)}; // @[src/main/scala/mini/Datapath.scala 223:82]
  wire [32:0] _regWrite_T_6 = 2'h1 == wb_sel ? $signed(load) : $signed(_regWrite_T); // @[src/main/scala/mini/Datapath.scala 222:39]
  wire [32:0] _regWrite_T_8 = 2'h2 == wb_sel ? $signed(_regWrite_T_3) : $signed(_regWrite_T_6); // @[src/main/scala/mini/Datapath.scala 222:39]
  wire [32:0] regWrite = 2'h3 == wb_sel ? $signed(_regWrite_T_4) : $signed(_regWrite_T_8); // @[src/main/scala/mini/Datapath.scala 224:7]
  reg  instCommit_predit_REG; // @[src/main/scala/mini/Datapath.scala 246:40]
  reg  instCommit_predit_REG_1; // @[src/main/scala/mini/Datapath.scala 246:32]
  wire  instCommit_predit = instCommit_predit_REG_1 | stall | reset; // @[src/main/scala/mini/Datapath.scala 246:148]
  reg [63:0] instOrder; // @[src/main/scala/mini/Datapath.scala 269:26]
  wire [63:0] _instOrder_T_1 = instOrder + 64'h1; // @[src/main/scala/mini/Datapath.scala 272:28]
  wire  instCommit = ~instCommit_predit; // @[src/main/scala/mini/Datapath.scala 247:17]
  reg  flywire_rs1_addr_REG; // @[src/main/scala/mini/Datapath.scala 284:34]
  wire  _flywire_rs1_addr_T_2 = io__ctrl_br_type != 3'h0; // @[src/main/scala/mini/Datapath.scala 284:99]
  reg  flywire_rs1_addr_REG_1; // @[src/main/scala/mini/Datapath.scala 284:82]
  reg  flywire_rs2_addr_REG; // @[src/main/scala/mini/Datapath.scala 285:34]
  reg  flywire_rs2_addr_REG_1; // @[src/main/scala/mini/Datapath.scala 285:82]
  reg  flywire_rs2_addr_REG_2; // @[src/main/scala/mini/Datapath.scala 285:130]
  reg [31:0] REG_4; // @[src/main/scala/mini/Datapath.scala 290:32]
  reg [31:0] REG_5; // @[src/main/scala/mini/Datapath.scala 291:32]
  wire [4:0] _T_18 = regFile_io_wen ? wb_rd_addr : 5'h0; // @[src/main/scala/mini/Datapath.scala 292:28]
  reg [34:0] REG_6; // @[src/main/scala/mini/Datapath.scala 296:32]
  wire [4:0] flywire_rs1_addr = flywire_rs1_addr_REG | flywire_rs1_addr_REG_1 ? ew_reg__inst[19:15] : 5'h0; // @[src/main/scala/mini/Datapath.scala 284:26]
  wire [4:0] flywire_rs2_addr = flywire_rs2_addr_REG | flywire_rs2_addr_REG_1 | flywire_rs2_addr_REG_2 ? ew_reg__inst[24
    :20] : 5'h0; // @[src/main/scala/mini/Datapath.scala 285:26]
  wire [32:0] _GEN_32 = reset ? 33'h0 : _GEN_0; // @[src/main/scala/mini/Datapath.scala 48:{23,23}]
  CSR csr ( // @[src/main/scala/mini/Datapath.scala 36:19]
    .clock(csr_clock),
    .reset(csr_reset),
    .io__stall(csr_io__stall),
    .io__cmd(csr_io__cmd),
    .io__in(csr_io__in),
    .io__out(csr_io__out),
    .io__pc(csr_io__pc),
    .io__addr(csr_io__addr),
    .io__inst(csr_io__inst),
    .io__illegal(csr_io__illegal),
    .io__st_type(csr_io__st_type),
    .io__ld_type(csr_io__ld_type),
    .io__pc_check(csr_io__pc_check),
    .io__expt(csr_io__expt),
    .io__evec(csr_io__evec),
    .io__epc(csr_io__epc),
    .io__host_fromhost_valid(csr_io__host_fromhost_valid),
    .io__host_fromhost_bits(csr_io__host_fromhost_bits),
    .io__host_tohost(csr_io__host_tohost),
    .io_expt(csr_io_expt)
  );
  RegFile regFile ( // @[src/main/scala/mini/Datapath.scala 37:23]
    .clock(regFile_clock),
    .io_raddr1(regFile_io_raddr1),
    .io_raddr2(regFile_io_raddr2),
    .io_rdata1(regFile_io_rdata1),
    .io_rdata2(regFile_io_rdata2),
    .io_wen(regFile_io_wen),
    .io_waddr(regFile_io_waddr),
    .io_wdata(regFile_io_wdata)
  );
  AluArea alu ( // @[src/main/scala/mini/Datapath.scala 38:19]
    .io_A(alu_io_A),
    .io_B(alu_io_B),
    .io_alu_op(alu_io_alu_op),
    .io_out(alu_io_out),
    .io_sum(alu_io_sum)
  );
  ImmGenWire immGen ( // @[src/main/scala/mini/Datapath.scala 39:22]
    .io_inst(immGen_io_inst),
    .io_sel(immGen_io_sel),
    .io_out(immGen_io_out)
  );
  BrCondArea brCond ( // @[src/main/scala/mini/Datapath.scala 40:22]
    .io_rs1(brCond_io_rs1),
    .io_rs2(brCond_io_rs2),
    .io_br_type(brCond_io_br_type),
    .io_taken(brCond_io_taken)
  );
  assign io__host_tohost = csr_io__host_tohost; // @[src/main/scala/mini/Datapath.scala 218:11]
  assign io__icache_req_valid = ~stall; // @[src/main/scala/mini/Datapath.scala 103:26]
  assign io__icache_req_bits_addr = next_pc[31:0]; // @[src/main/scala/mini/Datapath.scala 100:27]
  assign io__dcache_abort = csr_io__expt; // @[src/main/scala/mini/Datapath.scala 231:19]
  assign io__dcache_req_valid = _io_icache_req_valid_T & (|io__ctrl_st_type | |io__ctrl_ld_type); // @[src/main/scala/mini/Datapath.scala 147:33]
  assign io__dcache_req_bits_addr = daddr[31:0]; // @[src/main/scala/mini/Datapath.scala 148:27]
  assign io__dcache_req_bits_data = _io_dcache_req_bits_data_T[31:0]; // @[src/main/scala/mini/Datapath.scala 149:27]
  assign io__dcache_req_bits_mask = _io_dcache_req_bits_mask_T_10[3:0]; // @[src/main/scala/mini/Datapath.scala 150:27]
  assign io__ctrl_inst = fe_reg_inst; // @[src/main/scala/mini/Datapath.scala 114:16]
  assign _T_18_0 = _T_18;
  assign _T_9_0 = _T_9;
  assign REG_4_0 = REG_4;
  assign io_expt = csr_io_expt;
  assign ew_reg_inst = ew_reg__inst;
  assign REG_6_0 = REG_6;
  assign flywire_rs2_addr_0 = flywire_rs2_addr;
  assign ew_reg_pc = ew_reg__pc;
  assign _T_8_0 = _T_8;
  assign instOrder_0 = instOrder;
  assign io_dcache_resp_bits_data = io__dcache_resp_bits_data;
  assign load_mask_0 = load_mask;
  assign REG_3_0 = REG_3;
  assign flywire_rs1_addr_0 = flywire_rs1_addr;
  assign instCommit_0 = instCommit;
  assign REG_5_0 = REG_5;
  assign regWrite_0 = regWrite;
  assign REG_2_0 = REG_2;
  assign csr_clock = clock;
  assign csr_reset = reset;
  assign csr_io__stall = ~io__icache_resp_valid | ~io__dcache_resp_valid; // @[src/main/scala/mini/Datapath.scala 79:37]
  assign csr_io__cmd = csr_cmd; // @[src/main/scala/mini/Datapath.scala 210:14]
  assign csr_io__in = ew_reg__csr_in; // @[src/main/scala/mini/Datapath.scala 209:13]
  assign csr_io__pc = ew_reg__pc; // @[src/main/scala/mini/Datapath.scala 212:13]
  assign csr_io__addr = ew_reg__alu; // @[src/main/scala/mini/Datapath.scala 213:15]
  assign csr_io__inst = ew_reg__inst; // @[src/main/scala/mini/Datapath.scala 211:15]
  assign csr_io__illegal = illegal; // @[src/main/scala/mini/Datapath.scala 214:18]
  assign csr_io__st_type = st_type; // @[src/main/scala/mini/Datapath.scala 217:18]
  assign csr_io__ld_type = ld_type; // @[src/main/scala/mini/Datapath.scala 216:18]
  assign csr_io__pc_check = pc_check; // @[src/main/scala/mini/Datapath.scala 215:19]
  assign csr_io__host_fromhost_valid = io__host_fromhost_valid; // @[src/main/scala/mini/Datapath.scala 218:11]
  assign csr_io__host_fromhost_bits = io__host_fromhost_bits; // @[src/main/scala/mini/Datapath.scala 218:11]
  assign regFile_clock = clock;
  assign regFile_io_raddr1 = fe_reg_inst[19:15]; // @[src/main/scala/mini/Datapath.scala 118:29]
  assign regFile_io_raddr2 = fe_reg_inst[24:20]; // @[src/main/scala/mini/Datapath.scala 119:29]
  assign regFile_io_wen = wb_en & _io_icache_req_valid_T & _T_16; // @[src/main/scala/mini/Datapath.scala 226:37]
  assign regFile_io_waddr = ew_reg__inst[11:7]; // @[src/main/scala/mini/Datapath.scala 128:31]
  assign regFile_io_wdata = regWrite[31:0]; // @[src/main/scala/mini/Datapath.scala 228:20]
  assign alu_io_A = io__ctrl_A_sel ? rs1 : fe_reg_pc; // @[src/main/scala/mini/Datapath.scala 135:18]
  assign alu_io_B = io__ctrl_B_sel ? rs2 : immGen_io_out; // @[src/main/scala/mini/Datapath.scala 136:18]
  assign alu_io_alu_op = io__ctrl_alu_op; // @[src/main/scala/mini/Datapath.scala 137:17]
  assign immGen_io_inst = fe_reg_inst; // @[src/main/scala/mini/Datapath.scala 124:18]
  assign immGen_io_sel = io__ctrl_imm_sel; // @[src/main/scala/mini/Datapath.scala 125:17]
  assign brCond_io_rs1 = wb_sel == 2'h0 & rs1hazard ? ew_reg__alu : regFile_io_rdata1; // @[src/main/scala/mini/Datapath.scala 131:16]
  assign brCond_io_rs2 = _rs1_T & rs2hazard ? ew_reg__alu : regFile_io_rdata2; // @[src/main/scala/mini/Datapath.scala 132:16]
  assign brCond_io_br_type = io__ctrl_br_type; // @[src/main/scala/mini/Datapath.scala 142:21]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 48:23]
      fe_reg_inst <= 32'h13; // @[src/main/scala/mini/Datapath.scala 48:23]
    end else if (_io_icache_req_valid_T) begin // @[src/main/scala/mini/Datapath.scala 107:16]
      if (started | io__ctrl_inst_kill | brCond_io_taken | csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 96:8]
        fe_reg_inst <= 32'h13;
      end else begin
        fe_reg_inst <= io__icache_resp_bits_data;
      end
    end
    fe_reg_pc <= _GEN_32[31:0]; // @[src/main/scala/mini/Datapath.scala 48:{23,23}]
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 57:23]
      ew_reg__inst <= 32'h13; // @[src/main/scala/mini/Datapath.scala 57:23]
    end else if (!(reset | _io_icache_req_valid_T & csr_io__expt)) begin // @[src/main/scala/mini/Datapath.scala 155:47]
      if (_io_icache_req_valid_T & ~csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 162:38]
        ew_reg__inst <= fe_reg_inst; // @[src/main/scala/mini/Datapath.scala 164:17]
      end
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 57:23]
      ew_reg__pc <= 32'h0; // @[src/main/scala/mini/Datapath.scala 57:23]
    end else if (!(reset | _io_icache_req_valid_T & csr_io__expt)) begin // @[src/main/scala/mini/Datapath.scala 155:47]
      if (_io_icache_req_valid_T & ~csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 162:38]
        ew_reg__pc <= fe_reg_pc; // @[src/main/scala/mini/Datapath.scala 163:15]
      end
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 57:23]
      ew_reg__alu <= 32'h0; // @[src/main/scala/mini/Datapath.scala 57:23]
    end else if (!(reset | _io_icache_req_valid_T & csr_io__expt)) begin // @[src/main/scala/mini/Datapath.scala 155:47]
      if (_io_icache_req_valid_T & ~csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 162:38]
        ew_reg__alu <= alu_io_out; // @[src/main/scala/mini/Datapath.scala 165:16]
      end
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 57:23]
      ew_reg__csr_in <= 32'h0; // @[src/main/scala/mini/Datapath.scala 57:23]
    end else if (!(reset | _io_icache_req_valid_T & csr_io__expt)) begin // @[src/main/scala/mini/Datapath.scala 155:47]
      if (_io_icache_req_valid_T & ~csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 162:38]
        if (io__ctrl_imm_sel == 3'h6) begin // @[src/main/scala/mini/Datapath.scala 166:25]
          ew_reg__csr_in <= immGen_io_out;
        end else begin
          ew_reg__csr_in <= rs1;
        end
      end
    end
    if (reset | _io_icache_req_valid_T & csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 155:47]
      st_type <= 2'h0; // @[src/main/scala/mini/Datapath.scala 156:13]
    end else if (_io_icache_req_valid_T & ~csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 162:38]
      st_type <= io__ctrl_st_type; // @[src/main/scala/mini/Datapath.scala 167:13]
    end
    if (reset | _io_icache_req_valid_T & csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 155:47]
      ld_type <= 3'h0; // @[src/main/scala/mini/Datapath.scala 157:13]
    end else if (_io_icache_req_valid_T & ~csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 162:38]
      ld_type <= io__ctrl_ld_type; // @[src/main/scala/mini/Datapath.scala 168:13]
    end
    if (!(reset | _io_icache_req_valid_T & csr_io__expt)) begin // @[src/main/scala/mini/Datapath.scala 155:47]
      if (_io_icache_req_valid_T & ~csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 162:38]
        wb_sel <= io__ctrl_wb_sel; // @[src/main/scala/mini/Datapath.scala 169:12]
      end
    end
    if (reset | _io_icache_req_valid_T & csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 155:47]
      wb_en <= 1'h0; // @[src/main/scala/mini/Datapath.scala 158:11]
    end else if (_io_icache_req_valid_T & ~csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 162:38]
      wb_en <= io__ctrl_wb_en; // @[src/main/scala/mini/Datapath.scala 170:11]
    end
    if (reset | _io_icache_req_valid_T & csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 155:47]
      csr_cmd <= 3'h0; // @[src/main/scala/mini/Datapath.scala 159:13]
    end else if (_io_icache_req_valid_T & ~csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 162:38]
      csr_cmd <= io__ctrl_csr_cmd; // @[src/main/scala/mini/Datapath.scala 171:13]
    end
    if (reset | _io_icache_req_valid_T & csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 155:47]
      illegal <= 1'h0; // @[src/main/scala/mini/Datapath.scala 160:13]
    end else if (_io_icache_req_valid_T & ~csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 162:38]
      illegal <= io__ctrl_illegal; // @[src/main/scala/mini/Datapath.scala 172:13]
    end
    if (reset | _io_icache_req_valid_T & csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 155:47]
      pc_check <= 1'h0; // @[src/main/scala/mini/Datapath.scala 161:14]
    end else if (_io_icache_req_valid_T & ~csr_io__expt) begin // @[src/main/scala/mini/Datapath.scala 162:38]
      pc_check <= _next_pc_T_4; // @[src/main/scala/mini/Datapath.scala 173:14]
    end
    started <= reset; // @[src/main/scala/mini/Datapath.scala 78:31]
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 80:19]
      pc <= {{1'd0}, _pc_T_1}; // @[src/main/scala/mini/Datapath.scala 80:19]
    end else if (!(stall)) begin // @[src/main/scala/chisel3/util/Mux.scala 141:16]
      if (csr_io__expt) begin // @[src/main/scala/chisel3/util/Mux.scala 141:16]
        pc <= {{1'd0}, csr_io__evec};
      end else if (_next_pc_T_2) begin // @[src/main/scala/chisel3/util/Mux.scala 141:16]
        pc <= {{1'd0}, csr_io__epc};
      end else begin
        pc <= _next_pc_T_9;
      end
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 92:58]
      REG <= 1'h0; // @[src/main/scala/mini/Datapath.scala 92:58]
    end else begin
      REG <= stall | _next_pc_T_2 | _next_pc_T_3 | brCond_io_taken | _next_pc_T_7; // @[src/main/scala/mini/Datapath.scala 92:58]
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 93:58]
      REG_1 <= 33'h0; // @[src/main/scala/mini/Datapath.scala 93:58]
    end else if (stall) begin // @[src/main/scala/chisel3/util/Mux.scala 141:16]
      REG_1 <= pc;
    end else if (csr_io__expt) begin // @[src/main/scala/chisel3/util/Mux.scala 141:16]
      REG_1 <= {{1'd0}, csr_io__evec};
    end else if (_next_pc_T_2) begin // @[src/main/scala/chisel3/util/Mux.scala 141:16]
      REG_1 <= {{1'd0}, csr_io__epc};
    end else begin
      REG_1 <= _next_pc_T_9;
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 191:24]
      lw_addr <= 32'h0; // @[src/main/scala/mini/Datapath.scala 191:24]
    end else begin
      lw_addr <= alu_io_sum; // @[src/main/scala/mini/Datapath.scala 191:24]
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 205:32]
      REG_2 <= 4'h0; // @[src/main/scala/mini/Datapath.scala 205:32]
    end else begin
      REG_2 <= io__dcache_req_bits_mask; // @[src/main/scala/mini/Datapath.scala 205:32]
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 206:32]
      REG_3 <= 32'h0; // @[src/main/scala/mini/Datapath.scala 206:32]
    end else begin
      REG_3 <= io__dcache_req_bits_data; // @[src/main/scala/mini/Datapath.scala 206:32]
    end
    instCommit_predit_REG <= reset | _inst_T_2; // @[src/main/scala/mini/Datapath.scala 246:{40,40,40}]
    instCommit_predit_REG_1 <= reset | (instCommit_predit_REG | csr_io__expt); // @[src/main/scala/mini/Datapath.scala 246:{32,32,32}]
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 269:26]
      instOrder <= 64'h0; // @[src/main/scala/mini/Datapath.scala 269:26]
    end else if (instCommit) begin // @[src/main/scala/mini/Datapath.scala 271:19]
      instOrder <= _instOrder_T_1; // @[src/main/scala/mini/Datapath.scala 272:15]
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 284:34]
      flywire_rs1_addr_REG <= 1'h0; // @[src/main/scala/mini/Datapath.scala 284:34]
    end else begin
      flywire_rs1_addr_REG <= io__ctrl_A_sel; // @[src/main/scala/mini/Datapath.scala 284:34]
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 284:82]
      flywire_rs1_addr_REG_1 <= 1'h0; // @[src/main/scala/mini/Datapath.scala 284:82]
    end else begin
      flywire_rs1_addr_REG_1 <= io__ctrl_br_type != 3'h0; // @[src/main/scala/mini/Datapath.scala 284:82]
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 285:34]
      flywire_rs2_addr_REG <= 1'h0; // @[src/main/scala/mini/Datapath.scala 285:34]
    end else begin
      flywire_rs2_addr_REG <= io__ctrl_B_sel; // @[src/main/scala/mini/Datapath.scala 285:34]
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 285:82]
      flywire_rs2_addr_REG_1 <= 1'h0; // @[src/main/scala/mini/Datapath.scala 285:82]
    end else begin
      flywire_rs2_addr_REG_1 <= io__ctrl_st_type != 2'h0; // @[src/main/scala/mini/Datapath.scala 285:82]
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 285:130]
      flywire_rs2_addr_REG_2 <= 1'h0; // @[src/main/scala/mini/Datapath.scala 285:130]
    end else begin
      flywire_rs2_addr_REG_2 <= _flywire_rs1_addr_T_2; // @[src/main/scala/mini/Datapath.scala 285:130]
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 290:32]
      REG_4 <= 32'h0; // @[src/main/scala/mini/Datapath.scala 290:32]
    end else if (wb_sel == 2'h0 & rs1hazard) begin // @[src/main/scala/mini/Datapath.scala 131:16]
      REG_4 <= ew_reg__alu;
    end else begin
      REG_4 <= regFile_io_rdata1;
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 291:32]
      REG_5 <= 32'h0; // @[src/main/scala/mini/Datapath.scala 291:32]
    end else if (_rs1_T & rs2hazard) begin // @[src/main/scala/mini/Datapath.scala 132:16]
      REG_5 <= ew_reg__alu;
    end else begin
      REG_5 <= regFile_io_rdata2;
    end
    if (reset) begin // @[src/main/scala/mini/Datapath.scala 296:32]
      REG_6 <= 35'h0; // @[src/main/scala/mini/Datapath.scala 296:32]
    end else begin
      REG_6 <= daddr; // @[src/main/scala/mini/Datapath.scala 296:32]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fe_reg_inst = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  fe_reg_pc = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  ew_reg__inst = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  ew_reg__pc = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  ew_reg__alu = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  ew_reg__csr_in = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  st_type = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  ld_type = _RAND_7[2:0];
  _RAND_8 = {1{`RANDOM}};
  wb_sel = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  wb_en = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  csr_cmd = _RAND_10[2:0];
  _RAND_11 = {1{`RANDOM}};
  illegal = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  pc_check = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  started = _RAND_13[0:0];
  _RAND_14 = {2{`RANDOM}};
  pc = _RAND_14[32:0];
  _RAND_15 = {1{`RANDOM}};
  REG = _RAND_15[0:0];
  _RAND_16 = {2{`RANDOM}};
  REG_1 = _RAND_16[32:0];
  _RAND_17 = {1{`RANDOM}};
  lw_addr = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  REG_2 = _RAND_18[3:0];
  _RAND_19 = {1{`RANDOM}};
  REG_3 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  instCommit_predit_REG = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  instCommit_predit_REG_1 = _RAND_21[0:0];
  _RAND_22 = {2{`RANDOM}};
  instOrder = _RAND_22[63:0];
  _RAND_23 = {1{`RANDOM}};
  flywire_rs1_addr_REG = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  flywire_rs1_addr_REG_1 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  flywire_rs2_addr_REG = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  flywire_rs2_addr_REG_1 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  flywire_rs2_addr_REG_2 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  REG_4 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  REG_5 = _RAND_29[31:0];
  _RAND_30 = {2{`RANDOM}};
  REG_6 = _RAND_30[34:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Control(
  input  [31:0] io_inst, // @[src/main/scala/mini/Control.scala 146:14]
  output [1:0]  io_pc_sel, // @[src/main/scala/mini/Control.scala 146:14]
  output        io_inst_kill, // @[src/main/scala/mini/Control.scala 146:14]
  output        io_A_sel, // @[src/main/scala/mini/Control.scala 146:14]
  output        io_B_sel, // @[src/main/scala/mini/Control.scala 146:14]
  output [2:0]  io_imm_sel, // @[src/main/scala/mini/Control.scala 146:14]
  output [3:0]  io_alu_op, // @[src/main/scala/mini/Control.scala 146:14]
  output [2:0]  io_br_type, // @[src/main/scala/mini/Control.scala 146:14]
  output [1:0]  io_st_type, // @[src/main/scala/mini/Control.scala 146:14]
  output [2:0]  io_ld_type, // @[src/main/scala/mini/Control.scala 146:14]
  output [1:0]  io_wb_sel, // @[src/main/scala/mini/Control.scala 146:14]
  output        io_wb_en, // @[src/main/scala/mini/Control.scala 146:14]
  output [2:0]  io_csr_cmd, // @[src/main/scala/mini/Control.scala 146:14]
  output        io_illegal // @[src/main/scala/mini/Control.scala 146:14]
);
  wire [31:0] _ctrlSignals_T = io_inst & 32'h7f; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_1 = 32'h37 == _ctrlSignals_T; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_3 = 32'h17 == _ctrlSignals_T; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_5 = 32'h6f == _ctrlSignals_T; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire [31:0] _ctrlSignals_T_6 = io_inst & 32'h707f; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_7 = 32'h67 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_9 = 32'h63 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_11 = 32'h1063 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_13 = 32'h4063 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_15 = 32'h5063 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_17 = 32'h6063 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_19 = 32'h7063 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_21 = 32'h3 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_23 = 32'h1003 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_25 = 32'h2003 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_27 = 32'h4003 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_29 = 32'h5003 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_31 = 32'h23 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_33 = 32'h1023 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_35 = 32'h2023 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_37 = 32'h13 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_39 = 32'h2013 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_41 = 32'h3013 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_43 = 32'h4013 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_45 = 32'h6013 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_47 = 32'h7013 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire [31:0] _ctrlSignals_T_48 = io_inst & 32'hfe00707f; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_49 = 32'h1013 == _ctrlSignals_T_48; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_51 = 32'h5013 == _ctrlSignals_T_48; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_53 = 32'h40005013 == _ctrlSignals_T_48; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_55 = 32'h33 == _ctrlSignals_T_48; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_57 = 32'h40000033 == _ctrlSignals_T_48; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_59 = 32'h1033 == _ctrlSignals_T_48; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_61 = 32'h2033 == _ctrlSignals_T_48; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_63 = 32'h3033 == _ctrlSignals_T_48; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_65 = 32'h4033 == _ctrlSignals_T_48; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_67 = 32'h5033 == _ctrlSignals_T_48; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_69 = 32'h40005033 == _ctrlSignals_T_48; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_71 = 32'h6033 == _ctrlSignals_T_48; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_73 = 32'h7033 == _ctrlSignals_T_48; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire [31:0] _ctrlSignals_T_74 = io_inst & 32'hf00fffff; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_75 = 32'hf == _ctrlSignals_T_74; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_77 = 32'h100f == io_inst; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_79 = 32'h1073 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_81 = 32'h2073 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_83 = 32'h3073 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_85 = 32'h5073 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_87 = 32'h6073 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_89 = 32'h7073 == _ctrlSignals_T_6; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_91 = 32'h73 == io_inst; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_93 = 32'h100073 == io_inst; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_95 = 32'h10000073 == io_inst; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire  _ctrlSignals_T_97 = 32'h10200073 == io_inst; // @[src/main/scala/chisel3/util/Lookup.scala 31:38]
  wire [1:0] _ctrlSignals_T_99 = _ctrlSignals_T_95 ? 2'h3 : 2'h0; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_100 = _ctrlSignals_T_93 ? 2'h0 : _ctrlSignals_T_99; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_101 = _ctrlSignals_T_91 ? 2'h0 : _ctrlSignals_T_100; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_102 = _ctrlSignals_T_89 ? 2'h2 : _ctrlSignals_T_101; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_103 = _ctrlSignals_T_87 ? 2'h2 : _ctrlSignals_T_102; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_104 = _ctrlSignals_T_85 ? 2'h2 : _ctrlSignals_T_103; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_105 = _ctrlSignals_T_83 ? 2'h2 : _ctrlSignals_T_104; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_106 = _ctrlSignals_T_81 ? 2'h2 : _ctrlSignals_T_105; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_107 = _ctrlSignals_T_79 ? 2'h2 : _ctrlSignals_T_106; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_108 = _ctrlSignals_T_77 ? 2'h2 : _ctrlSignals_T_107; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_109 = _ctrlSignals_T_75 ? 2'h0 : _ctrlSignals_T_108; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_110 = _ctrlSignals_T_73 ? 2'h0 : _ctrlSignals_T_109; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_111 = _ctrlSignals_T_71 ? 2'h0 : _ctrlSignals_T_110; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_112 = _ctrlSignals_T_69 ? 2'h0 : _ctrlSignals_T_111; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_113 = _ctrlSignals_T_67 ? 2'h0 : _ctrlSignals_T_112; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_114 = _ctrlSignals_T_65 ? 2'h0 : _ctrlSignals_T_113; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_115 = _ctrlSignals_T_63 ? 2'h0 : _ctrlSignals_T_114; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_116 = _ctrlSignals_T_61 ? 2'h0 : _ctrlSignals_T_115; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_117 = _ctrlSignals_T_59 ? 2'h0 : _ctrlSignals_T_116; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_118 = _ctrlSignals_T_57 ? 2'h0 : _ctrlSignals_T_117; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_119 = _ctrlSignals_T_55 ? 2'h0 : _ctrlSignals_T_118; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_120 = _ctrlSignals_T_53 ? 2'h0 : _ctrlSignals_T_119; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_121 = _ctrlSignals_T_51 ? 2'h0 : _ctrlSignals_T_120; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_122 = _ctrlSignals_T_49 ? 2'h0 : _ctrlSignals_T_121; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_123 = _ctrlSignals_T_47 ? 2'h0 : _ctrlSignals_T_122; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_124 = _ctrlSignals_T_45 ? 2'h0 : _ctrlSignals_T_123; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_125 = _ctrlSignals_T_43 ? 2'h0 : _ctrlSignals_T_124; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_126 = _ctrlSignals_T_41 ? 2'h0 : _ctrlSignals_T_125; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_127 = _ctrlSignals_T_39 ? 2'h0 : _ctrlSignals_T_126; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_128 = _ctrlSignals_T_37 ? 2'h0 : _ctrlSignals_T_127; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_129 = _ctrlSignals_T_35 ? 2'h0 : _ctrlSignals_T_128; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_130 = _ctrlSignals_T_33 ? 2'h0 : _ctrlSignals_T_129; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_131 = _ctrlSignals_T_31 ? 2'h0 : _ctrlSignals_T_130; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_132 = _ctrlSignals_T_29 ? 2'h2 : _ctrlSignals_T_131; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_133 = _ctrlSignals_T_27 ? 2'h2 : _ctrlSignals_T_132; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_134 = _ctrlSignals_T_25 ? 2'h2 : _ctrlSignals_T_133; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_135 = _ctrlSignals_T_23 ? 2'h2 : _ctrlSignals_T_134; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_136 = _ctrlSignals_T_21 ? 2'h2 : _ctrlSignals_T_135; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_137 = _ctrlSignals_T_19 ? 2'h0 : _ctrlSignals_T_136; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_138 = _ctrlSignals_T_17 ? 2'h0 : _ctrlSignals_T_137; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_139 = _ctrlSignals_T_15 ? 2'h0 : _ctrlSignals_T_138; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_140 = _ctrlSignals_T_13 ? 2'h0 : _ctrlSignals_T_139; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_141 = _ctrlSignals_T_11 ? 2'h0 : _ctrlSignals_T_140; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_142 = _ctrlSignals_T_9 ? 2'h0 : _ctrlSignals_T_141; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_143 = _ctrlSignals_T_7 ? 2'h1 : _ctrlSignals_T_142; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_144 = _ctrlSignals_T_5 ? 2'h1 : _ctrlSignals_T_143; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_145 = _ctrlSignals_T_3 ? 2'h0 : _ctrlSignals_T_144; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_156 = _ctrlSignals_T_77 ? 1'h0 : _ctrlSignals_T_79 | (_ctrlSignals_T_81 | _ctrlSignals_T_83); // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_157 = _ctrlSignals_T_75 ? 1'h0 : _ctrlSignals_T_156; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_185 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_21 | (_ctrlSignals_T_23 | (_ctrlSignals_T_25 | (
    _ctrlSignals_T_27 | (_ctrlSignals_T_29 | (_ctrlSignals_T_31 | (_ctrlSignals_T_33 | (_ctrlSignals_T_35 | (
    _ctrlSignals_T_37 | (_ctrlSignals_T_39 | (_ctrlSignals_T_41 | (_ctrlSignals_T_43 | (_ctrlSignals_T_45 | (
    _ctrlSignals_T_47 | (_ctrlSignals_T_49 | (_ctrlSignals_T_51 | (_ctrlSignals_T_53 | (_ctrlSignals_T_55 | (
    _ctrlSignals_T_57 | (_ctrlSignals_T_59 | (_ctrlSignals_T_61 | (_ctrlSignals_T_63 | (_ctrlSignals_T_65 | (
    _ctrlSignals_T_67 | (_ctrlSignals_T_69 | (_ctrlSignals_T_71 | (_ctrlSignals_T_73 | _ctrlSignals_T_157)))))))))))))))
    ))))))))))); // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_186 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_185; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_187 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_186; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_188 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_187; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_189 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_188; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_190 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_189; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_192 = _ctrlSignals_T_5 ? 1'h0 : _ctrlSignals_T_7 | _ctrlSignals_T_190; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_193 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_192; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_216 = _ctrlSignals_T_53 ? 1'h0 : _ctrlSignals_T_55 | (_ctrlSignals_T_57 | (_ctrlSignals_T_59 | (
    _ctrlSignals_T_61 | (_ctrlSignals_T_63 | (_ctrlSignals_T_65 | (_ctrlSignals_T_67 | (_ctrlSignals_T_69 | (
    _ctrlSignals_T_71 | _ctrlSignals_T_73)))))))); // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_217 = _ctrlSignals_T_51 ? 1'h0 : _ctrlSignals_T_216; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_218 = _ctrlSignals_T_49 ? 1'h0 : _ctrlSignals_T_217; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_219 = _ctrlSignals_T_47 ? 1'h0 : _ctrlSignals_T_218; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_220 = _ctrlSignals_T_45 ? 1'h0 : _ctrlSignals_T_219; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_221 = _ctrlSignals_T_43 ? 1'h0 : _ctrlSignals_T_220; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_222 = _ctrlSignals_T_41 ? 1'h0 : _ctrlSignals_T_221; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_223 = _ctrlSignals_T_39 ? 1'h0 : _ctrlSignals_T_222; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_224 = _ctrlSignals_T_37 ? 1'h0 : _ctrlSignals_T_223; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_225 = _ctrlSignals_T_35 ? 1'h0 : _ctrlSignals_T_224; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_226 = _ctrlSignals_T_33 ? 1'h0 : _ctrlSignals_T_225; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_227 = _ctrlSignals_T_31 ? 1'h0 : _ctrlSignals_T_226; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_228 = _ctrlSignals_T_29 ? 1'h0 : _ctrlSignals_T_227; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_229 = _ctrlSignals_T_27 ? 1'h0 : _ctrlSignals_T_228; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_230 = _ctrlSignals_T_25 ? 1'h0 : _ctrlSignals_T_229; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_231 = _ctrlSignals_T_23 ? 1'h0 : _ctrlSignals_T_230; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_232 = _ctrlSignals_T_21 ? 1'h0 : _ctrlSignals_T_231; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_233 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_232; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_234 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_233; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_235 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_234; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_236 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_235; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_237 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_236; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_238 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_237; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_239 = _ctrlSignals_T_7 ? 1'h0 : _ctrlSignals_T_238; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_240 = _ctrlSignals_T_5 ? 1'h0 : _ctrlSignals_T_239; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_241 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_240; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_246 = _ctrlSignals_T_89 ? 3'h6 : 3'h0; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_247 = _ctrlSignals_T_87 ? 3'h6 : _ctrlSignals_T_246; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_248 = _ctrlSignals_T_85 ? 3'h6 : _ctrlSignals_T_247; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_249 = _ctrlSignals_T_83 ? 3'h0 : _ctrlSignals_T_248; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_250 = _ctrlSignals_T_81 ? 3'h0 : _ctrlSignals_T_249; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_251 = _ctrlSignals_T_79 ? 3'h0 : _ctrlSignals_T_250; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_252 = _ctrlSignals_T_77 ? 3'h0 : _ctrlSignals_T_251; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_253 = _ctrlSignals_T_75 ? 3'h0 : _ctrlSignals_T_252; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_254 = _ctrlSignals_T_73 ? 3'h0 : _ctrlSignals_T_253; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_255 = _ctrlSignals_T_71 ? 3'h0 : _ctrlSignals_T_254; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_256 = _ctrlSignals_T_69 ? 3'h0 : _ctrlSignals_T_255; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_257 = _ctrlSignals_T_67 ? 3'h0 : _ctrlSignals_T_256; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_258 = _ctrlSignals_T_65 ? 3'h0 : _ctrlSignals_T_257; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_259 = _ctrlSignals_T_63 ? 3'h0 : _ctrlSignals_T_258; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_260 = _ctrlSignals_T_61 ? 3'h0 : _ctrlSignals_T_259; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_261 = _ctrlSignals_T_59 ? 3'h0 : _ctrlSignals_T_260; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_262 = _ctrlSignals_T_57 ? 3'h0 : _ctrlSignals_T_261; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_263 = _ctrlSignals_T_55 ? 3'h0 : _ctrlSignals_T_262; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_264 = _ctrlSignals_T_53 ? 3'h1 : _ctrlSignals_T_263; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_265 = _ctrlSignals_T_51 ? 3'h1 : _ctrlSignals_T_264; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_266 = _ctrlSignals_T_49 ? 3'h1 : _ctrlSignals_T_265; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_267 = _ctrlSignals_T_47 ? 3'h1 : _ctrlSignals_T_266; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_268 = _ctrlSignals_T_45 ? 3'h1 : _ctrlSignals_T_267; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_269 = _ctrlSignals_T_43 ? 3'h1 : _ctrlSignals_T_268; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_270 = _ctrlSignals_T_41 ? 3'h1 : _ctrlSignals_T_269; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_271 = _ctrlSignals_T_39 ? 3'h1 : _ctrlSignals_T_270; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_272 = _ctrlSignals_T_37 ? 3'h1 : _ctrlSignals_T_271; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_273 = _ctrlSignals_T_35 ? 3'h2 : _ctrlSignals_T_272; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_274 = _ctrlSignals_T_33 ? 3'h2 : _ctrlSignals_T_273; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_275 = _ctrlSignals_T_31 ? 3'h2 : _ctrlSignals_T_274; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_276 = _ctrlSignals_T_29 ? 3'h1 : _ctrlSignals_T_275; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_277 = _ctrlSignals_T_27 ? 3'h1 : _ctrlSignals_T_276; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_278 = _ctrlSignals_T_25 ? 3'h1 : _ctrlSignals_T_277; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_279 = _ctrlSignals_T_23 ? 3'h1 : _ctrlSignals_T_278; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_280 = _ctrlSignals_T_21 ? 3'h1 : _ctrlSignals_T_279; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_281 = _ctrlSignals_T_19 ? 3'h5 : _ctrlSignals_T_280; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_282 = _ctrlSignals_T_17 ? 3'h5 : _ctrlSignals_T_281; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_283 = _ctrlSignals_T_15 ? 3'h5 : _ctrlSignals_T_282; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_284 = _ctrlSignals_T_13 ? 3'h5 : _ctrlSignals_T_283; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_285 = _ctrlSignals_T_11 ? 3'h5 : _ctrlSignals_T_284; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_286 = _ctrlSignals_T_9 ? 3'h5 : _ctrlSignals_T_285; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_287 = _ctrlSignals_T_7 ? 3'h1 : _ctrlSignals_T_286; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_288 = _ctrlSignals_T_5 ? 3'h4 : _ctrlSignals_T_287; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_289 = _ctrlSignals_T_3 ? 3'h3 : _ctrlSignals_T_288; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_297 = _ctrlSignals_T_83 ? 4'ha : 4'hf; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_298 = _ctrlSignals_T_81 ? 4'ha : _ctrlSignals_T_297; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_299 = _ctrlSignals_T_79 ? 4'ha : _ctrlSignals_T_298; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_300 = _ctrlSignals_T_77 ? 4'hf : _ctrlSignals_T_299; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_301 = _ctrlSignals_T_75 ? 4'hf : _ctrlSignals_T_300; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_302 = _ctrlSignals_T_73 ? 4'h2 : _ctrlSignals_T_301; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_303 = _ctrlSignals_T_71 ? 4'h3 : _ctrlSignals_T_302; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_304 = _ctrlSignals_T_69 ? 4'h9 : _ctrlSignals_T_303; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_305 = _ctrlSignals_T_67 ? 4'h8 : _ctrlSignals_T_304; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_306 = _ctrlSignals_T_65 ? 4'h4 : _ctrlSignals_T_305; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_307 = _ctrlSignals_T_63 ? 4'h7 : _ctrlSignals_T_306; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_308 = _ctrlSignals_T_61 ? 4'h5 : _ctrlSignals_T_307; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_309 = _ctrlSignals_T_59 ? 4'h6 : _ctrlSignals_T_308; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_310 = _ctrlSignals_T_57 ? 4'h1 : _ctrlSignals_T_309; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_311 = _ctrlSignals_T_55 ? 4'h0 : _ctrlSignals_T_310; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_312 = _ctrlSignals_T_53 ? 4'h9 : _ctrlSignals_T_311; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_313 = _ctrlSignals_T_51 ? 4'h8 : _ctrlSignals_T_312; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_314 = _ctrlSignals_T_49 ? 4'h6 : _ctrlSignals_T_313; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_315 = _ctrlSignals_T_47 ? 4'h2 : _ctrlSignals_T_314; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_316 = _ctrlSignals_T_45 ? 4'h3 : _ctrlSignals_T_315; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_317 = _ctrlSignals_T_43 ? 4'h4 : _ctrlSignals_T_316; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_318 = _ctrlSignals_T_41 ? 4'h7 : _ctrlSignals_T_317; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_319 = _ctrlSignals_T_39 ? 4'h5 : _ctrlSignals_T_318; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_320 = _ctrlSignals_T_37 ? 4'hc : _ctrlSignals_T_319; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_321 = _ctrlSignals_T_35 ? 4'h0 : _ctrlSignals_T_320; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_322 = _ctrlSignals_T_33 ? 4'h0 : _ctrlSignals_T_321; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_323 = _ctrlSignals_T_31 ? 4'h0 : _ctrlSignals_T_322; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_324 = _ctrlSignals_T_29 ? 4'h0 : _ctrlSignals_T_323; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_325 = _ctrlSignals_T_27 ? 4'h0 : _ctrlSignals_T_324; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_326 = _ctrlSignals_T_25 ? 4'h0 : _ctrlSignals_T_325; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_327 = _ctrlSignals_T_23 ? 4'h0 : _ctrlSignals_T_326; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_328 = _ctrlSignals_T_21 ? 4'h0 : _ctrlSignals_T_327; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_329 = _ctrlSignals_T_19 ? 4'h0 : _ctrlSignals_T_328; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_330 = _ctrlSignals_T_17 ? 4'h0 : _ctrlSignals_T_329; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_331 = _ctrlSignals_T_15 ? 4'h0 : _ctrlSignals_T_330; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_332 = _ctrlSignals_T_13 ? 4'h0 : _ctrlSignals_T_331; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_333 = _ctrlSignals_T_11 ? 4'h0 : _ctrlSignals_T_332; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_334 = _ctrlSignals_T_9 ? 4'h0 : _ctrlSignals_T_333; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_335 = _ctrlSignals_T_7 ? 4'h0 : _ctrlSignals_T_334; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_336 = _ctrlSignals_T_5 ? 4'h0 : _ctrlSignals_T_335; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_337 = _ctrlSignals_T_3 ? 4'h0 : _ctrlSignals_T_336; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_377 = _ctrlSignals_T_19 ? 3'h4 : 3'h0; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_378 = _ctrlSignals_T_17 ? 3'h1 : _ctrlSignals_T_377; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_379 = _ctrlSignals_T_15 ? 3'h5 : _ctrlSignals_T_378; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_380 = _ctrlSignals_T_13 ? 3'h2 : _ctrlSignals_T_379; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_381 = _ctrlSignals_T_11 ? 3'h6 : _ctrlSignals_T_380; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_382 = _ctrlSignals_T_9 ? 3'h3 : _ctrlSignals_T_381; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_383 = _ctrlSignals_T_7 ? 3'h0 : _ctrlSignals_T_382; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_384 = _ctrlSignals_T_5 ? 3'h0 : _ctrlSignals_T_383; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_385 = _ctrlSignals_T_3 ? 3'h0 : _ctrlSignals_T_384; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_388 = _ctrlSignals_T_93 ? 1'h0 : _ctrlSignals_T_95; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_389 = _ctrlSignals_T_91 ? 1'h0 : _ctrlSignals_T_388; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_397 = _ctrlSignals_T_75 ? 1'h0 : _ctrlSignals_T_77 | (_ctrlSignals_T_79 | (_ctrlSignals_T_81 | (
    _ctrlSignals_T_83 | (_ctrlSignals_T_85 | (_ctrlSignals_T_87 | (_ctrlSignals_T_89 | _ctrlSignals_T_389)))))); // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_398 = _ctrlSignals_T_73 ? 1'h0 : _ctrlSignals_T_397; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_399 = _ctrlSignals_T_71 ? 1'h0 : _ctrlSignals_T_398; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_400 = _ctrlSignals_T_69 ? 1'h0 : _ctrlSignals_T_399; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_401 = _ctrlSignals_T_67 ? 1'h0 : _ctrlSignals_T_400; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_402 = _ctrlSignals_T_65 ? 1'h0 : _ctrlSignals_T_401; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_403 = _ctrlSignals_T_63 ? 1'h0 : _ctrlSignals_T_402; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_404 = _ctrlSignals_T_61 ? 1'h0 : _ctrlSignals_T_403; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_405 = _ctrlSignals_T_59 ? 1'h0 : _ctrlSignals_T_404; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_406 = _ctrlSignals_T_57 ? 1'h0 : _ctrlSignals_T_405; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_407 = _ctrlSignals_T_55 ? 1'h0 : _ctrlSignals_T_406; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_408 = _ctrlSignals_T_53 ? 1'h0 : _ctrlSignals_T_407; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_409 = _ctrlSignals_T_51 ? 1'h0 : _ctrlSignals_T_408; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_410 = _ctrlSignals_T_49 ? 1'h0 : _ctrlSignals_T_409; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_411 = _ctrlSignals_T_47 ? 1'h0 : _ctrlSignals_T_410; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_412 = _ctrlSignals_T_45 ? 1'h0 : _ctrlSignals_T_411; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_413 = _ctrlSignals_T_43 ? 1'h0 : _ctrlSignals_T_412; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_414 = _ctrlSignals_T_41 ? 1'h0 : _ctrlSignals_T_413; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_415 = _ctrlSignals_T_39 ? 1'h0 : _ctrlSignals_T_414; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_416 = _ctrlSignals_T_37 ? 1'h0 : _ctrlSignals_T_415; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_417 = _ctrlSignals_T_35 ? 1'h0 : _ctrlSignals_T_416; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_418 = _ctrlSignals_T_33 ? 1'h0 : _ctrlSignals_T_417; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_419 = _ctrlSignals_T_31 ? 1'h0 : _ctrlSignals_T_418; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_425 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_21 | (_ctrlSignals_T_23 | (_ctrlSignals_T_25 | (
    _ctrlSignals_T_27 | (_ctrlSignals_T_29 | _ctrlSignals_T_419)))); // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_426 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_425; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_427 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_426; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_428 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_427; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_429 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_428; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_430 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_429; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_433 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_5 | (_ctrlSignals_T_7 | _ctrlSignals_T_430); // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_465 = _ctrlSignals_T_35 ? 2'h1 : 2'h0; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_466 = _ctrlSignals_T_33 ? 2'h2 : _ctrlSignals_T_465; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_467 = _ctrlSignals_T_31 ? 2'h3 : _ctrlSignals_T_466; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_468 = _ctrlSignals_T_29 ? 2'h0 : _ctrlSignals_T_467; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_469 = _ctrlSignals_T_27 ? 2'h0 : _ctrlSignals_T_468; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_470 = _ctrlSignals_T_25 ? 2'h0 : _ctrlSignals_T_469; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_471 = _ctrlSignals_T_23 ? 2'h0 : _ctrlSignals_T_470; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_472 = _ctrlSignals_T_21 ? 2'h0 : _ctrlSignals_T_471; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_473 = _ctrlSignals_T_19 ? 2'h0 : _ctrlSignals_T_472; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_474 = _ctrlSignals_T_17 ? 2'h0 : _ctrlSignals_T_473; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_475 = _ctrlSignals_T_15 ? 2'h0 : _ctrlSignals_T_474; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_476 = _ctrlSignals_T_13 ? 2'h0 : _ctrlSignals_T_475; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_477 = _ctrlSignals_T_11 ? 2'h0 : _ctrlSignals_T_476; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_478 = _ctrlSignals_T_9 ? 2'h0 : _ctrlSignals_T_477; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_479 = _ctrlSignals_T_7 ? 2'h0 : _ctrlSignals_T_478; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_480 = _ctrlSignals_T_5 ? 2'h0 : _ctrlSignals_T_479; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_481 = _ctrlSignals_T_3 ? 2'h0 : _ctrlSignals_T_480; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_516 = _ctrlSignals_T_29 ? 3'h4 : 3'h0; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_517 = _ctrlSignals_T_27 ? 3'h5 : _ctrlSignals_T_516; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_518 = _ctrlSignals_T_25 ? 3'h1 : _ctrlSignals_T_517; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_519 = _ctrlSignals_T_23 ? 3'h2 : _ctrlSignals_T_518; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_520 = _ctrlSignals_T_21 ? 3'h3 : _ctrlSignals_T_519; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_521 = _ctrlSignals_T_19 ? 3'h0 : _ctrlSignals_T_520; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_522 = _ctrlSignals_T_17 ? 3'h0 : _ctrlSignals_T_521; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_523 = _ctrlSignals_T_15 ? 3'h0 : _ctrlSignals_T_522; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_524 = _ctrlSignals_T_13 ? 3'h0 : _ctrlSignals_T_523; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_525 = _ctrlSignals_T_11 ? 3'h0 : _ctrlSignals_T_524; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_526 = _ctrlSignals_T_9 ? 3'h0 : _ctrlSignals_T_525; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_527 = _ctrlSignals_T_7 ? 3'h0 : _ctrlSignals_T_526; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_528 = _ctrlSignals_T_5 ? 3'h0 : _ctrlSignals_T_527; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_529 = _ctrlSignals_T_3 ? 3'h0 : _ctrlSignals_T_528; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_532 = _ctrlSignals_T_93 ? 2'h3 : _ctrlSignals_T_99; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_533 = _ctrlSignals_T_91 ? 2'h3 : _ctrlSignals_T_532; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_534 = _ctrlSignals_T_89 ? 2'h3 : _ctrlSignals_T_533; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_535 = _ctrlSignals_T_87 ? 2'h3 : _ctrlSignals_T_534; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_536 = _ctrlSignals_T_85 ? 2'h3 : _ctrlSignals_T_535; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_537 = _ctrlSignals_T_83 ? 2'h3 : _ctrlSignals_T_536; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_538 = _ctrlSignals_T_81 ? 2'h3 : _ctrlSignals_T_537; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_539 = _ctrlSignals_T_79 ? 2'h3 : _ctrlSignals_T_538; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_540 = _ctrlSignals_T_77 ? 2'h0 : _ctrlSignals_T_539; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_541 = _ctrlSignals_T_75 ? 2'h0 : _ctrlSignals_T_540; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_542 = _ctrlSignals_T_73 ? 2'h0 : _ctrlSignals_T_541; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_543 = _ctrlSignals_T_71 ? 2'h0 : _ctrlSignals_T_542; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_544 = _ctrlSignals_T_69 ? 2'h0 : _ctrlSignals_T_543; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_545 = _ctrlSignals_T_67 ? 2'h0 : _ctrlSignals_T_544; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_546 = _ctrlSignals_T_65 ? 2'h0 : _ctrlSignals_T_545; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_547 = _ctrlSignals_T_63 ? 2'h0 : _ctrlSignals_T_546; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_548 = _ctrlSignals_T_61 ? 2'h0 : _ctrlSignals_T_547; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_549 = _ctrlSignals_T_59 ? 2'h0 : _ctrlSignals_T_548; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_550 = _ctrlSignals_T_57 ? 2'h0 : _ctrlSignals_T_549; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_551 = _ctrlSignals_T_55 ? 2'h0 : _ctrlSignals_T_550; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_552 = _ctrlSignals_T_53 ? 2'h0 : _ctrlSignals_T_551; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_553 = _ctrlSignals_T_51 ? 2'h0 : _ctrlSignals_T_552; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_554 = _ctrlSignals_T_49 ? 2'h0 : _ctrlSignals_T_553; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_555 = _ctrlSignals_T_47 ? 2'h0 : _ctrlSignals_T_554; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_556 = _ctrlSignals_T_45 ? 2'h0 : _ctrlSignals_T_555; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_557 = _ctrlSignals_T_43 ? 2'h0 : _ctrlSignals_T_556; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_558 = _ctrlSignals_T_41 ? 2'h0 : _ctrlSignals_T_557; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_559 = _ctrlSignals_T_39 ? 2'h0 : _ctrlSignals_T_558; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_560 = _ctrlSignals_T_37 ? 2'h0 : _ctrlSignals_T_559; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_561 = _ctrlSignals_T_35 ? 2'h0 : _ctrlSignals_T_560; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_562 = _ctrlSignals_T_33 ? 2'h0 : _ctrlSignals_T_561; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_563 = _ctrlSignals_T_31 ? 2'h0 : _ctrlSignals_T_562; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_564 = _ctrlSignals_T_29 ? 2'h1 : _ctrlSignals_T_563; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_565 = _ctrlSignals_T_27 ? 2'h1 : _ctrlSignals_T_564; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_566 = _ctrlSignals_T_25 ? 2'h1 : _ctrlSignals_T_565; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_567 = _ctrlSignals_T_23 ? 2'h1 : _ctrlSignals_T_566; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_568 = _ctrlSignals_T_21 ? 2'h1 : _ctrlSignals_T_567; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_569 = _ctrlSignals_T_19 ? 2'h0 : _ctrlSignals_T_568; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_570 = _ctrlSignals_T_17 ? 2'h0 : _ctrlSignals_T_569; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_571 = _ctrlSignals_T_15 ? 2'h0 : _ctrlSignals_T_570; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_572 = _ctrlSignals_T_13 ? 2'h0 : _ctrlSignals_T_571; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_573 = _ctrlSignals_T_11 ? 2'h0 : _ctrlSignals_T_572; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_574 = _ctrlSignals_T_9 ? 2'h0 : _ctrlSignals_T_573; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_575 = _ctrlSignals_T_7 ? 2'h2 : _ctrlSignals_T_574; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_576 = _ctrlSignals_T_5 ? 2'h2 : _ctrlSignals_T_575; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_577 = _ctrlSignals_T_3 ? 2'h0 : _ctrlSignals_T_576; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_588 = _ctrlSignals_T_77 ? 1'h0 : _ctrlSignals_T_79 | (_ctrlSignals_T_81 | (_ctrlSignals_T_83 | (
    _ctrlSignals_T_85 | (_ctrlSignals_T_87 | _ctrlSignals_T_89)))); // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_589 = _ctrlSignals_T_75 ? 1'h0 : _ctrlSignals_T_588; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_609 = _ctrlSignals_T_35 ? 1'h0 : _ctrlSignals_T_37 | (_ctrlSignals_T_39 | (_ctrlSignals_T_41 | (
    _ctrlSignals_T_43 | (_ctrlSignals_T_45 | (_ctrlSignals_T_47 | (_ctrlSignals_T_49 | (_ctrlSignals_T_51 | (
    _ctrlSignals_T_53 | (_ctrlSignals_T_55 | (_ctrlSignals_T_57 | (_ctrlSignals_T_59 | (_ctrlSignals_T_61 | (
    _ctrlSignals_T_63 | (_ctrlSignals_T_65 | (_ctrlSignals_T_67 | (_ctrlSignals_T_69 | (_ctrlSignals_T_71 | (
    _ctrlSignals_T_73 | _ctrlSignals_T_589)))))))))))))))))); // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_610 = _ctrlSignals_T_33 ? 1'h0 : _ctrlSignals_T_609; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_611 = _ctrlSignals_T_31 ? 1'h0 : _ctrlSignals_T_610; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_617 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_21 | (_ctrlSignals_T_23 | (_ctrlSignals_T_25 | (
    _ctrlSignals_T_27 | (_ctrlSignals_T_29 | _ctrlSignals_T_611)))); // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_618 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_617; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_619 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_618; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_620 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_619; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_621 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_620; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_622 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_621; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_627 = _ctrlSignals_T_95 ? 3'h4 : 3'h0; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_628 = _ctrlSignals_T_93 ? 3'h4 : _ctrlSignals_T_627; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_629 = _ctrlSignals_T_91 ? 3'h4 : _ctrlSignals_T_628; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_630 = _ctrlSignals_T_89 ? 3'h3 : _ctrlSignals_T_629; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_631 = _ctrlSignals_T_87 ? 3'h2 : _ctrlSignals_T_630; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_632 = _ctrlSignals_T_85 ? 3'h1 : _ctrlSignals_T_631; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_633 = _ctrlSignals_T_83 ? 3'h3 : _ctrlSignals_T_632; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_634 = _ctrlSignals_T_81 ? 3'h2 : _ctrlSignals_T_633; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_635 = _ctrlSignals_T_79 ? 3'h1 : _ctrlSignals_T_634; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_636 = _ctrlSignals_T_77 ? 3'h0 : _ctrlSignals_T_635; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_637 = _ctrlSignals_T_75 ? 3'h0 : _ctrlSignals_T_636; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_638 = _ctrlSignals_T_73 ? 3'h0 : _ctrlSignals_T_637; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_639 = _ctrlSignals_T_71 ? 3'h0 : _ctrlSignals_T_638; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_640 = _ctrlSignals_T_69 ? 3'h0 : _ctrlSignals_T_639; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_641 = _ctrlSignals_T_67 ? 3'h0 : _ctrlSignals_T_640; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_642 = _ctrlSignals_T_65 ? 3'h0 : _ctrlSignals_T_641; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_643 = _ctrlSignals_T_63 ? 3'h0 : _ctrlSignals_T_642; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_644 = _ctrlSignals_T_61 ? 3'h0 : _ctrlSignals_T_643; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_645 = _ctrlSignals_T_59 ? 3'h0 : _ctrlSignals_T_644; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_646 = _ctrlSignals_T_57 ? 3'h0 : _ctrlSignals_T_645; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_647 = _ctrlSignals_T_55 ? 3'h0 : _ctrlSignals_T_646; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_648 = _ctrlSignals_T_53 ? 3'h0 : _ctrlSignals_T_647; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_649 = _ctrlSignals_T_51 ? 3'h0 : _ctrlSignals_T_648; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_650 = _ctrlSignals_T_49 ? 3'h0 : _ctrlSignals_T_649; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_651 = _ctrlSignals_T_47 ? 3'h0 : _ctrlSignals_T_650; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_652 = _ctrlSignals_T_45 ? 3'h0 : _ctrlSignals_T_651; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_653 = _ctrlSignals_T_43 ? 3'h0 : _ctrlSignals_T_652; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_654 = _ctrlSignals_T_41 ? 3'h0 : _ctrlSignals_T_653; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_655 = _ctrlSignals_T_39 ? 3'h0 : _ctrlSignals_T_654; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_656 = _ctrlSignals_T_37 ? 3'h0 : _ctrlSignals_T_655; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_657 = _ctrlSignals_T_35 ? 3'h0 : _ctrlSignals_T_656; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_658 = _ctrlSignals_T_33 ? 3'h0 : _ctrlSignals_T_657; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_659 = _ctrlSignals_T_31 ? 3'h0 : _ctrlSignals_T_658; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_660 = _ctrlSignals_T_29 ? 3'h0 : _ctrlSignals_T_659; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_661 = _ctrlSignals_T_27 ? 3'h0 : _ctrlSignals_T_660; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_662 = _ctrlSignals_T_25 ? 3'h0 : _ctrlSignals_T_661; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_663 = _ctrlSignals_T_23 ? 3'h0 : _ctrlSignals_T_662; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_664 = _ctrlSignals_T_21 ? 3'h0 : _ctrlSignals_T_663; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_665 = _ctrlSignals_T_19 ? 3'h0 : _ctrlSignals_T_664; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_666 = _ctrlSignals_T_17 ? 3'h0 : _ctrlSignals_T_665; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_667 = _ctrlSignals_T_15 ? 3'h0 : _ctrlSignals_T_666; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_668 = _ctrlSignals_T_13 ? 3'h0 : _ctrlSignals_T_667; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_669 = _ctrlSignals_T_11 ? 3'h0 : _ctrlSignals_T_668; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_670 = _ctrlSignals_T_9 ? 3'h0 : _ctrlSignals_T_669; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_671 = _ctrlSignals_T_7 ? 3'h0 : _ctrlSignals_T_670; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_672 = _ctrlSignals_T_5 ? 3'h0 : _ctrlSignals_T_671; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_673 = _ctrlSignals_T_3 ? 3'h0 : _ctrlSignals_T_672; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_674 = _ctrlSignals_T_97 ? 1'h0 : 1'h1; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_675 = _ctrlSignals_T_95 ? 1'h0 : _ctrlSignals_T_674; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_676 = _ctrlSignals_T_93 ? 1'h0 : _ctrlSignals_T_675; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_677 = _ctrlSignals_T_91 ? 1'h0 : _ctrlSignals_T_676; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_678 = _ctrlSignals_T_89 ? 1'h0 : _ctrlSignals_T_677; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_679 = _ctrlSignals_T_87 ? 1'h0 : _ctrlSignals_T_678; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_680 = _ctrlSignals_T_85 ? 1'h0 : _ctrlSignals_T_679; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_681 = _ctrlSignals_T_83 ? 1'h0 : _ctrlSignals_T_680; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_682 = _ctrlSignals_T_81 ? 1'h0 : _ctrlSignals_T_681; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_683 = _ctrlSignals_T_79 ? 1'h0 : _ctrlSignals_T_682; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_684 = _ctrlSignals_T_77 ? 1'h0 : _ctrlSignals_T_683; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_685 = _ctrlSignals_T_75 ? 1'h0 : _ctrlSignals_T_684; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_686 = _ctrlSignals_T_73 ? 1'h0 : _ctrlSignals_T_685; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_687 = _ctrlSignals_T_71 ? 1'h0 : _ctrlSignals_T_686; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_688 = _ctrlSignals_T_69 ? 1'h0 : _ctrlSignals_T_687; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_689 = _ctrlSignals_T_67 ? 1'h0 : _ctrlSignals_T_688; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_690 = _ctrlSignals_T_65 ? 1'h0 : _ctrlSignals_T_689; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_691 = _ctrlSignals_T_63 ? 1'h0 : _ctrlSignals_T_690; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_692 = _ctrlSignals_T_61 ? 1'h0 : _ctrlSignals_T_691; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_693 = _ctrlSignals_T_59 ? 1'h0 : _ctrlSignals_T_692; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_694 = _ctrlSignals_T_57 ? 1'h0 : _ctrlSignals_T_693; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_695 = _ctrlSignals_T_55 ? 1'h0 : _ctrlSignals_T_694; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_696 = _ctrlSignals_T_53 ? 1'h0 : _ctrlSignals_T_695; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_697 = _ctrlSignals_T_51 ? 1'h0 : _ctrlSignals_T_696; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_698 = _ctrlSignals_T_49 ? 1'h0 : _ctrlSignals_T_697; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_699 = _ctrlSignals_T_47 ? 1'h0 : _ctrlSignals_T_698; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_700 = _ctrlSignals_T_45 ? 1'h0 : _ctrlSignals_T_699; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_701 = _ctrlSignals_T_43 ? 1'h0 : _ctrlSignals_T_700; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_702 = _ctrlSignals_T_41 ? 1'h0 : _ctrlSignals_T_701; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_703 = _ctrlSignals_T_39 ? 1'h0 : _ctrlSignals_T_702; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_704 = _ctrlSignals_T_37 ? 1'h0 : _ctrlSignals_T_703; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_705 = _ctrlSignals_T_35 ? 1'h0 : _ctrlSignals_T_704; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_706 = _ctrlSignals_T_33 ? 1'h0 : _ctrlSignals_T_705; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_707 = _ctrlSignals_T_31 ? 1'h0 : _ctrlSignals_T_706; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_708 = _ctrlSignals_T_29 ? 1'h0 : _ctrlSignals_T_707; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_709 = _ctrlSignals_T_27 ? 1'h0 : _ctrlSignals_T_708; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_710 = _ctrlSignals_T_25 ? 1'h0 : _ctrlSignals_T_709; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_711 = _ctrlSignals_T_23 ? 1'h0 : _ctrlSignals_T_710; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_712 = _ctrlSignals_T_21 ? 1'h0 : _ctrlSignals_T_711; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_713 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_712; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_714 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_713; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_715 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_714; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_716 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_715; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_717 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_716; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_718 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_717; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_719 = _ctrlSignals_T_7 ? 1'h0 : _ctrlSignals_T_718; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_720 = _ctrlSignals_T_5 ? 1'h0 : _ctrlSignals_T_719; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  wire  _ctrlSignals_T_721 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_720; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  assign io_pc_sel = _ctrlSignals_T_1 ? 2'h0 : _ctrlSignals_T_145; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  assign io_inst_kill = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_433; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  assign io_A_sel = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_193; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  assign io_B_sel = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_241; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  assign io_imm_sel = _ctrlSignals_T_1 ? 3'h3 : _ctrlSignals_T_289; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  assign io_alu_op = _ctrlSignals_T_1 ? 4'hb : _ctrlSignals_T_337; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  assign io_br_type = _ctrlSignals_T_1 ? 3'h0 : _ctrlSignals_T_385; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  assign io_st_type = _ctrlSignals_T_1 ? 2'h0 : _ctrlSignals_T_481; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  assign io_ld_type = _ctrlSignals_T_1 ? 3'h0 : _ctrlSignals_T_529; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  assign io_wb_sel = _ctrlSignals_T_1 ? 2'h0 : _ctrlSignals_T_577; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  assign io_wb_en = _ctrlSignals_T_1 | (_ctrlSignals_T_3 | (_ctrlSignals_T_5 | (_ctrlSignals_T_7 | _ctrlSignals_T_622)))
    ; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  assign io_csr_cmd = _ctrlSignals_T_1 ? 3'h0 : _ctrlSignals_T_673; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
  assign io_illegal = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_721; // @[src/main/scala/chisel3/util/Lookup.scala 34:39]
endmodule
module Core(
  input         clock,
  input         reset,
  input         io_host_fromhost_valid, // @[src/main/scala/mini/Core.scala 93:14]
  input  [31:0] io_host_fromhost_bits, // @[src/main/scala/mini/Core.scala 93:14]
  output [31:0] io_host_tohost, // @[src/main/scala/mini/Core.scala 93:14]
  output        io_icache_abort, // @[src/main/scala/mini/Core.scala 93:14]
  output        io_icache_req_valid, // @[src/main/scala/mini/Core.scala 93:14]
  output [31:0] io_icache_req_bits_addr, // @[src/main/scala/mini/Core.scala 93:14]
  output [31:0] io_icache_req_bits_data, // @[src/main/scala/mini/Core.scala 93:14]
  output [3:0]  io_icache_req_bits_mask, // @[src/main/scala/mini/Core.scala 93:14]
  input         io_icache_resp_valid, // @[src/main/scala/mini/Core.scala 93:14]
  input  [31:0] io_icache_resp_bits_data, // @[src/main/scala/mini/Core.scala 93:14]
  output        io_dcache_abort, // @[src/main/scala/mini/Core.scala 93:14]
  output        io_dcache_req_valid, // @[src/main/scala/mini/Core.scala 93:14]
  output [31:0] io_dcache_req_bits_addr, // @[src/main/scala/mini/Core.scala 93:14]
  output [31:0] io_dcache_req_bits_data, // @[src/main/scala/mini/Core.scala 93:14]
  output [3:0]  io_dcache_req_bits_mask, // @[src/main/scala/mini/Core.scala 93:14]
  input         io_dcache_resp_valid, // @[src/main/scala/mini/Core.scala 93:14]
  input  [31:0] io_dcache_resp_bits_data, // @[src/main/scala/mini/Core.scala 93:14]
  output        rvfi_valid, // @[src/main/scala/mini/Core.scala 96:18]
  output [63:0] rvfi_order, // @[src/main/scala/mini/Core.scala 96:18]
  output [31:0] rvfi_insn, // @[src/main/scala/mini/Core.scala 96:18]
  output        rvfi_trap, // @[src/main/scala/mini/Core.scala 96:18]
  output        rvfi_halt, // @[src/main/scala/mini/Core.scala 96:18]
  output        rvfi_intr, // @[src/main/scala/mini/Core.scala 96:18]
  output [1:0]  rvfi_mode, // @[src/main/scala/mini/Core.scala 96:18]
  output [1:0]  rvfi_ixl, // @[src/main/scala/mini/Core.scala 96:18]
  output [4:0]  rvfi_rs1_addr, // @[src/main/scala/mini/Core.scala 96:18]
  output [4:0]  rvfi_rs2_addr, // @[src/main/scala/mini/Core.scala 96:18]
  output [31:0] rvfi_rs1_rdata, // @[src/main/scala/mini/Core.scala 96:18]
  output [31:0] rvfi_rs2_rdata, // @[src/main/scala/mini/Core.scala 96:18]
  output [4:0]  rvfi_rd_addr, // @[src/main/scala/mini/Core.scala 96:18]
  output [31:0] rvfi_rd_wdata, // @[src/main/scala/mini/Core.scala 96:18]
  output [31:0] rvfi_pc_rdata, // @[src/main/scala/mini/Core.scala 96:18]
  output [31:0] rvfi_pc_wdata, // @[src/main/scala/mini/Core.scala 96:18]
  output [31:0] rvfi_mem_addr, // @[src/main/scala/mini/Core.scala 96:18]
  output [3:0]  rvfi_mem_rmask, // @[src/main/scala/mini/Core.scala 96:18]
  output [3:0]  rvfi_mem_wmask, // @[src/main/scala/mini/Core.scala 96:18]
  output [31:0] rvfi_mem_rdata, // @[src/main/scala/mini/Core.scala 96:18]
  output [31:0] rvfi_mem_wdata // @[src/main/scala/mini/Core.scala 96:18]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  dpath_clock; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath_reset; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath_io__host_fromhost_valid; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] dpath_io__host_fromhost_bits; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] dpath_io__host_tohost; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath_io__icache_req_valid; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] dpath_io__icache_req_bits_addr; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath_io__icache_resp_valid; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] dpath_io__icache_resp_bits_data; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath_io__dcache_abort; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath_io__dcache_req_valid; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] dpath_io__dcache_req_bits_addr; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] dpath_io__dcache_req_bits_data; // @[src/main/scala/mini/Core.scala 94:21]
  wire [3:0] dpath_io__dcache_req_bits_mask; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath_io__dcache_resp_valid; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] dpath_io__dcache_resp_bits_data; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] dpath_io__ctrl_inst; // @[src/main/scala/mini/Core.scala 94:21]
  wire [1:0] dpath_io__ctrl_pc_sel; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath_io__ctrl_inst_kill; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath_io__ctrl_A_sel; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath_io__ctrl_B_sel; // @[src/main/scala/mini/Core.scala 94:21]
  wire [2:0] dpath_io__ctrl_imm_sel; // @[src/main/scala/mini/Core.scala 94:21]
  wire [3:0] dpath_io__ctrl_alu_op; // @[src/main/scala/mini/Core.scala 94:21]
  wire [2:0] dpath_io__ctrl_br_type; // @[src/main/scala/mini/Core.scala 94:21]
  wire [1:0] dpath_io__ctrl_st_type; // @[src/main/scala/mini/Core.scala 94:21]
  wire [2:0] dpath_io__ctrl_ld_type; // @[src/main/scala/mini/Core.scala 94:21]
  wire [1:0] dpath_io__ctrl_wb_sel; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath_io__ctrl_wb_en; // @[src/main/scala/mini/Core.scala 94:21]
  wire [2:0] dpath_io__ctrl_csr_cmd; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath_io__ctrl_illegal; // @[src/main/scala/mini/Core.scala 94:21]
  wire [4:0] dpath__T_18_0; // @[src/main/scala/mini/Core.scala 94:21]
  wire [32:0] dpath__T_9_0; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] dpath_REG_4_0; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath_io_expt; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] dpath_ew_reg_inst; // @[src/main/scala/mini/Core.scala 94:21]
  wire [34:0] dpath_REG_6_0; // @[src/main/scala/mini/Core.scala 94:21]
  wire [4:0] dpath_flywire_rs2_addr_0; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] dpath_ew_reg_pc; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath__T_8_0; // @[src/main/scala/mini/Core.scala 94:21]
  wire [63:0] dpath_instOrder_0; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] dpath_io_dcache_resp_bits_data; // @[src/main/scala/mini/Core.scala 94:21]
  wire [4:0] dpath_load_mask_0; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] dpath_REG_3_0; // @[src/main/scala/mini/Core.scala 94:21]
  wire [4:0] dpath_flywire_rs1_addr_0; // @[src/main/scala/mini/Core.scala 94:21]
  wire  dpath_instCommit_0; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] dpath_REG_5_0; // @[src/main/scala/mini/Core.scala 94:21]
  wire [32:0] dpath_regWrite_0; // @[src/main/scala/mini/Core.scala 94:21]
  wire [3:0] dpath_REG_2_0; // @[src/main/scala/mini/Core.scala 94:21]
  wire [31:0] ctrl_io_inst; // @[src/main/scala/mini/Core.scala 95:20]
  wire [1:0] ctrl_io_pc_sel; // @[src/main/scala/mini/Core.scala 95:20]
  wire  ctrl_io_inst_kill; // @[src/main/scala/mini/Core.scala 95:20]
  wire  ctrl_io_A_sel; // @[src/main/scala/mini/Core.scala 95:20]
  wire  ctrl_io_B_sel; // @[src/main/scala/mini/Core.scala 95:20]
  wire [2:0] ctrl_io_imm_sel; // @[src/main/scala/mini/Core.scala 95:20]
  wire [3:0] ctrl_io_alu_op; // @[src/main/scala/mini/Core.scala 95:20]
  wire [2:0] ctrl_io_br_type; // @[src/main/scala/mini/Core.scala 95:20]
  wire [1:0] ctrl_io_st_type; // @[src/main/scala/mini/Core.scala 95:20]
  wire [2:0] ctrl_io_ld_type; // @[src/main/scala/mini/Core.scala 95:20]
  wire [1:0] ctrl_io_wb_sel; // @[src/main/scala/mini/Core.scala 95:20]
  wire  ctrl_io_wb_en; // @[src/main/scala/mini/Core.scala 95:20]
  wire [2:0] ctrl_io_csr_cmd; // @[src/main/scala/mini/Core.scala 95:20]
  wire  ctrl_io_illegal; // @[src/main/scala/mini/Core.scala 95:20]
  wire [4:0] rvfiio_rs1_addr = dpath_flywire_rs1_addr_0;
  wire [31:0] rvfiio_rs1_rdata = dpath_REG_4_0;
  wire [4:0] rvfiio_rs2_addr = dpath_flywire_rs2_addr_0;
  wire [31:0] rvfiio_rs2_rdata = dpath_REG_5_0;
  wire [4:0] rvfiio_rd_addr = dpath__T_18_0;
  wire [32:0] rvfiio_rd_wdata = dpath_regWrite_0;
  wire [31:0] rd_wdata_ssd = rvfiio_rd_wdata[31:0]; // @[src/main/scala/mini/Core.scala 128:27]
  wire [31:0] _rvfi_pc_wdata_T_1 = rvfi_pc_rdata + 32'h4; // @[src/main/scala/mini/Core.scala 199:36]
  wire  Jumpornot = dpath__T_8_0;
  wire [32:0] rvfiio_pc_jump_data = dpath__T_9_0;
  wire [31:0] pc_wdata_test = rvfiio_pc_jump_data[31:0]; // @[src/main/scala/mini/Core.scala 187:27]
  reg  REG; // @[src/main/scala/mini/Core.scala 208:14]
  wire [4:0] rvfiio_mem_rmask = dpath_load_mask_0;
  wire [31:0] rvfiio_mem_rdata = dpath_io_dcache_resp_bits_data;
  wire [34:0] rvfiio_mem_addr = dpath_REG_6_0;
  Datapath dpath ( // @[src/main/scala/mini/Core.scala 94:21]
    .clock(dpath_clock),
    .reset(dpath_reset),
    .io__host_fromhost_valid(dpath_io__host_fromhost_valid),
    .io__host_fromhost_bits(dpath_io__host_fromhost_bits),
    .io__host_tohost(dpath_io__host_tohost),
    .io__icache_req_valid(dpath_io__icache_req_valid),
    .io__icache_req_bits_addr(dpath_io__icache_req_bits_addr),
    .io__icache_resp_valid(dpath_io__icache_resp_valid),
    .io__icache_resp_bits_data(dpath_io__icache_resp_bits_data),
    .io__dcache_abort(dpath_io__dcache_abort),
    .io__dcache_req_valid(dpath_io__dcache_req_valid),
    .io__dcache_req_bits_addr(dpath_io__dcache_req_bits_addr),
    .io__dcache_req_bits_data(dpath_io__dcache_req_bits_data),
    .io__dcache_req_bits_mask(dpath_io__dcache_req_bits_mask),
    .io__dcache_resp_valid(dpath_io__dcache_resp_valid),
    .io__dcache_resp_bits_data(dpath_io__dcache_resp_bits_data),
    .io__ctrl_inst(dpath_io__ctrl_inst),
    .io__ctrl_pc_sel(dpath_io__ctrl_pc_sel),
    .io__ctrl_inst_kill(dpath_io__ctrl_inst_kill),
    .io__ctrl_A_sel(dpath_io__ctrl_A_sel),
    .io__ctrl_B_sel(dpath_io__ctrl_B_sel),
    .io__ctrl_imm_sel(dpath_io__ctrl_imm_sel),
    .io__ctrl_alu_op(dpath_io__ctrl_alu_op),
    .io__ctrl_br_type(dpath_io__ctrl_br_type),
    .io__ctrl_st_type(dpath_io__ctrl_st_type),
    .io__ctrl_ld_type(dpath_io__ctrl_ld_type),
    .io__ctrl_wb_sel(dpath_io__ctrl_wb_sel),
    .io__ctrl_wb_en(dpath_io__ctrl_wb_en),
    .io__ctrl_csr_cmd(dpath_io__ctrl_csr_cmd),
    .io__ctrl_illegal(dpath_io__ctrl_illegal),
    ._T_18_0(dpath__T_18_0),
    ._T_9_0(dpath__T_9_0),
    .REG_4_0(dpath_REG_4_0),
    .io_expt(dpath_io_expt),
    .ew_reg_inst(dpath_ew_reg_inst),
    .REG_6_0(dpath_REG_6_0),
    .flywire_rs2_addr_0(dpath_flywire_rs2_addr_0),
    .ew_reg_pc(dpath_ew_reg_pc),
    ._T_8_0(dpath__T_8_0),
    .instOrder_0(dpath_instOrder_0),
    .io_dcache_resp_bits_data(dpath_io_dcache_resp_bits_data),
    .load_mask_0(dpath_load_mask_0),
    .REG_3_0(dpath_REG_3_0),
    .flywire_rs1_addr_0(dpath_flywire_rs1_addr_0),
    .instCommit_0(dpath_instCommit_0),
    .REG_5_0(dpath_REG_5_0),
    .regWrite_0(dpath_regWrite_0),
    .REG_2_0(dpath_REG_2_0)
  );
  Control ctrl ( // @[src/main/scala/mini/Core.scala 95:20]
    .io_inst(ctrl_io_inst),
    .io_pc_sel(ctrl_io_pc_sel),
    .io_inst_kill(ctrl_io_inst_kill),
    .io_A_sel(ctrl_io_A_sel),
    .io_B_sel(ctrl_io_B_sel),
    .io_imm_sel(ctrl_io_imm_sel),
    .io_alu_op(ctrl_io_alu_op),
    .io_br_type(ctrl_io_br_type),
    .io_st_type(ctrl_io_st_type),
    .io_ld_type(ctrl_io_ld_type),
    .io_wb_sel(ctrl_io_wb_sel),
    .io_wb_en(ctrl_io_wb_en),
    .io_csr_cmd(ctrl_io_csr_cmd),
    .io_illegal(ctrl_io_illegal)
  );
  assign io_host_tohost = dpath_io__host_tohost; // @[src/main/scala/mini/Core.scala 98:11]
  assign io_icache_abort = 1'h0; // @[src/main/scala/mini/Core.scala 99:19]
  assign io_icache_req_valid = dpath_io__icache_req_valid; // @[src/main/scala/mini/Core.scala 99:19]
  assign io_icache_req_bits_addr = dpath_io__icache_req_bits_addr; // @[src/main/scala/mini/Core.scala 99:19]
  assign io_icache_req_bits_data = 32'h0; // @[src/main/scala/mini/Core.scala 99:19]
  assign io_icache_req_bits_mask = 4'h0; // @[src/main/scala/mini/Core.scala 99:19]
  assign io_dcache_abort = dpath_io__dcache_abort; // @[src/main/scala/mini/Core.scala 100:19]
  assign io_dcache_req_valid = dpath_io__dcache_req_valid; // @[src/main/scala/mini/Core.scala 100:19]
  assign io_dcache_req_bits_addr = dpath_io__dcache_req_bits_addr; // @[src/main/scala/mini/Core.scala 100:19]
  assign io_dcache_req_bits_data = dpath_io__dcache_req_bits_data; // @[src/main/scala/mini/Core.scala 100:19]
  assign io_dcache_req_bits_mask = dpath_io__dcache_req_bits_mask; // @[src/main/scala/mini/Core.scala 100:19]
  assign rvfi_valid = dpath_instCommit_0; // @[src/main/scala/mini/Core.scala 104:22]
  assign rvfi_order = dpath_instOrder_0; // @[src/main/scala/mini/Core.scala 104:22]
  assign rvfi_insn = dpath_ew_reg_inst; // @[src/main/scala/mini/Core.scala 106:25]
  assign rvfi_trap = dpath_io_expt; // @[src/main/scala/mini/Core.scala 104:22]
  assign rvfi_halt = 1'h0; // @[src/main/scala/mini/Core.scala 104:22 119:17]
  assign rvfi_intr = 1'h0; // @[src/main/scala/mini/Core.scala 104:22 120:17]
  assign rvfi_mode = 2'h3; // @[src/main/scala/mini/Core.scala 104:22 121:17]
  assign rvfi_ixl = 2'h1; // @[src/main/scala/mini/Core.scala 104:22 122:17]
  assign rvfi_rs1_addr = dpath_flywire_rs1_addr_0; // @[src/main/scala/mini/Core.scala 123:35]
  assign rvfi_rs2_addr = dpath_flywire_rs2_addr_0; // @[src/main/scala/mini/Core.scala 124:35]
  assign rvfi_rs1_rdata = rvfiio_rs1_addr == 5'h0 ? 32'h0 : rvfiio_rs1_rdata; // @[src/main/scala/mini/Core.scala 145:38 146:24 148:24]
  assign rvfi_rs2_rdata = rvfiio_rs2_addr == 5'h0 ? 32'h0 : rvfiio_rs2_rdata; // @[src/main/scala/mini/Core.scala 150:38 151:24 153:24]
  assign rvfi_rd_addr = dpath__T_18_0; // @[src/main/scala/mini/Core.scala 104:22]
  assign rvfi_rd_wdata = rvfiio_rd_addr == 5'h0 ? 32'h0 : rd_wdata_ssd; // @[src/main/scala/mini/Core.scala 156:37 157:23 159:23]
  assign rvfi_pc_rdata = dpath_ew_reg_pc; // @[src/main/scala/mini/Core.scala 104:22]
  assign rvfi_pc_wdata = Jumpornot ? pc_wdata_test : _rvfi_pc_wdata_T_1; // @[src/main/scala/mini/Core.scala 196:16 197:19 199:19]
  assign rvfi_mem_addr = rvfiio_mem_addr[31:0]; // @[src/main/scala/mini/Core.scala 104:22]
  assign rvfi_mem_rmask = rvfiio_mem_rmask[3:0]; // @[src/main/scala/mini/Core.scala 104:22]
  assign rvfi_mem_wmask = dpath_REG_2_0; // @[src/main/scala/mini/Core.scala 104:22]
  assign rvfi_mem_rdata = dpath_io_dcache_resp_bits_data; // @[src/main/scala/mini/Core.scala 104:22]
  assign rvfi_mem_wdata = dpath_REG_3_0; // @[src/main/scala/mini/Core.scala 104:22]
  assign dpath_clock = clock;
  assign dpath_reset = reset;
  assign dpath_io__host_fromhost_valid = io_host_fromhost_valid; // @[src/main/scala/mini/Core.scala 98:11]
  assign dpath_io__host_fromhost_bits = io_host_fromhost_bits; // @[src/main/scala/mini/Core.scala 98:11]
  assign dpath_io__icache_resp_valid = io_icache_resp_valid; // @[src/main/scala/mini/Core.scala 99:19]
  assign dpath_io__icache_resp_bits_data = io_icache_resp_bits_data; // @[src/main/scala/mini/Core.scala 99:19]
  assign dpath_io__dcache_resp_valid = io_dcache_resp_valid; // @[src/main/scala/mini/Core.scala 100:19]
  assign dpath_io__dcache_resp_bits_data = io_dcache_resp_bits_data; // @[src/main/scala/mini/Core.scala 100:19]
  assign dpath_io__ctrl_pc_sel = ctrl_io_pc_sel; // @[src/main/scala/mini/Core.scala 101:17]
  assign dpath_io__ctrl_inst_kill = ctrl_io_inst_kill; // @[src/main/scala/mini/Core.scala 101:17]
  assign dpath_io__ctrl_A_sel = ctrl_io_A_sel; // @[src/main/scala/mini/Core.scala 101:17]
  assign dpath_io__ctrl_B_sel = ctrl_io_B_sel; // @[src/main/scala/mini/Core.scala 101:17]
  assign dpath_io__ctrl_imm_sel = ctrl_io_imm_sel; // @[src/main/scala/mini/Core.scala 101:17]
  assign dpath_io__ctrl_alu_op = ctrl_io_alu_op; // @[src/main/scala/mini/Core.scala 101:17]
  assign dpath_io__ctrl_br_type = ctrl_io_br_type; // @[src/main/scala/mini/Core.scala 101:17]
  assign dpath_io__ctrl_st_type = ctrl_io_st_type; // @[src/main/scala/mini/Core.scala 101:17]
  assign dpath_io__ctrl_ld_type = ctrl_io_ld_type; // @[src/main/scala/mini/Core.scala 101:17]
  assign dpath_io__ctrl_wb_sel = ctrl_io_wb_sel; // @[src/main/scala/mini/Core.scala 101:17]
  assign dpath_io__ctrl_wb_en = ctrl_io_wb_en; // @[src/main/scala/mini/Core.scala 101:17]
  assign dpath_io__ctrl_csr_cmd = ctrl_io_csr_cmd; // @[src/main/scala/mini/Core.scala 101:17]
  assign dpath_io__ctrl_illegal = ctrl_io_illegal; // @[src/main/scala/mini/Core.scala 101:17]
  assign ctrl_io_inst = dpath_io__ctrl_inst; // @[src/main/scala/mini/Core.scala 101:17]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/mini/Core.scala 208:14]
      REG <= 1'h0; // @[src/main/scala/mini/Core.scala 208:14]
    end else begin
      REG <= rvfi_trap; // @[src/main/scala/mini/Core.scala 208:14]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (rvfi_valid & ~reset) begin
          $fwrite(32'h80000002,
            "[RVFI Print%x][trapnext:%x][Expt:%x]Mem_rmask:%x, ADDR:%x Core: valid=%d order=%x insn=%x Jump:%d JumpTarget: %x rd_addr=%d rd_data=%x rs1_addr=%d rs1_data=%x rs2_addr=%d rs2_data=%x PCr=%x, PCw=%x\n"
            ,rvfiio_mem_rdata,REG,rvfi_trap,rvfi_mem_rmask,rvfi_mem_addr,rvfi_valid,rvfi_order,rvfi_insn,Jumpornot,
            rvfi_pc_wdata,rvfi_rd_addr,rvfi_rd_wdata,rvfi_rs1_addr,rvfi_rs1_rdata,rvfi_rs2_addr,rvfi_rs2_rdata,
            rvfi_pc_rdata,rvfi_pc_wdata); // @[src/main/scala/mini/Core.scala 203:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  REG = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
