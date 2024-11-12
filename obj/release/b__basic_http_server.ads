pragma Warnings (Off);
pragma Ada_95;
with System;
with System.Parameters;
with System.Secondary_Stack;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: 14.2.0" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   GNAT_Version_Address : constant System.Address := GNAT_Version'Address;
   pragma Export (C, GNAT_Version_Address, "__gnat_version_address");

   Ada_Main_Program_Name : constant String := "_ada_basic_http_server" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#10cf9648#;
   pragma Export (C, u00001, "basic_http_serverB");
   u00002 : constant Version_32 := 16#30305195#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#0626cc96#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#76789da1#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#700cc663#;
   pragma Export (C, u00005, "ada__directoriesB");
   u00006 : constant Version_32 := 16#420441ec#;
   pragma Export (C, u00006, "ada__directoriesS");
   u00007 : constant Version_32 := 16#21b023a2#;
   pragma Export (C, u00007, "ada__calendarB");
   u00008 : constant Version_32 := 16#63f2c9c2#;
   pragma Export (C, u00008, "ada__calendarS");
   u00009 : constant Version_32 := 16#9a5d1b93#;
   pragma Export (C, u00009, "ada__exceptionsB");
   u00010 : constant Version_32 := 16#64d9391c#;
   pragma Export (C, u00010, "ada__exceptionsS");
   u00011 : constant Version_32 := 16#0740df23#;
   pragma Export (C, u00011, "ada__exceptions__last_chance_handlerB");
   u00012 : constant Version_32 := 16#a028f72d#;
   pragma Export (C, u00012, "ada__exceptions__last_chance_handlerS");
   u00013 : constant Version_32 := 16#14286b0f#;
   pragma Export (C, u00013, "systemS");
   u00014 : constant Version_32 := 16#fd5f5f4c#;
   pragma Export (C, u00014, "system__soft_linksB");
   u00015 : constant Version_32 := 16#455c24f2#;
   pragma Export (C, u00015, "system__soft_linksS");
   u00016 : constant Version_32 := 16#524f7d04#;
   pragma Export (C, u00016, "system__secondary_stackB");
   u00017 : constant Version_32 := 16#bae33a03#;
   pragma Export (C, u00017, "system__secondary_stackS");
   u00018 : constant Version_32 := 16#a43efea2#;
   pragma Export (C, u00018, "system__parametersB");
   u00019 : constant Version_32 := 16#21bf971e#;
   pragma Export (C, u00019, "system__parametersS");
   u00020 : constant Version_32 := 16#d8f6bfe7#;
   pragma Export (C, u00020, "system__storage_elementsS");
   u00021 : constant Version_32 := 16#0286ce9f#;
   pragma Export (C, u00021, "system__soft_links__initializeB");
   u00022 : constant Version_32 := 16#2ed17187#;
   pragma Export (C, u00022, "system__soft_links__initializeS");
   u00023 : constant Version_32 := 16#8599b27b#;
   pragma Export (C, u00023, "system__stack_checkingB");
   u00024 : constant Version_32 := 16#d3777e19#;
   pragma Export (C, u00024, "system__stack_checkingS");
   u00025 : constant Version_32 := 16#c71e6c8a#;
   pragma Export (C, u00025, "system__exception_tableB");
   u00026 : constant Version_32 := 16#99031d16#;
   pragma Export (C, u00026, "system__exception_tableS");
   u00027 : constant Version_32 := 16#268dd43d#;
   pragma Export (C, u00027, "system__exceptionsS");
   u00028 : constant Version_32 := 16#69416224#;
   pragma Export (C, u00028, "system__exceptions__machineB");
   u00029 : constant Version_32 := 16#46355a4a#;
   pragma Export (C, u00029, "system__exceptions__machineS");
   u00030 : constant Version_32 := 16#7706238d#;
   pragma Export (C, u00030, "system__exceptions_debugB");
   u00031 : constant Version_32 := 16#2426335c#;
   pragma Export (C, u00031, "system__exceptions_debugS");
   u00032 : constant Version_32 := 16#36b7284e#;
   pragma Export (C, u00032, "system__img_intS");
   u00033 : constant Version_32 := 16#f2c63a02#;
   pragma Export (C, u00033, "ada__numericsS");
   u00034 : constant Version_32 := 16#174f5472#;
   pragma Export (C, u00034, "ada__numerics__big_numbersS");
   u00035 : constant Version_32 := 16#ee021456#;
   pragma Export (C, u00035, "system__unsigned_typesS");
   u00036 : constant Version_32 := 16#5c7d9c20#;
   pragma Export (C, u00036, "system__tracebackB");
   u00037 : constant Version_32 := 16#92b29fb2#;
   pragma Export (C, u00037, "system__tracebackS");
   u00038 : constant Version_32 := 16#5f6b6486#;
   pragma Export (C, u00038, "system__traceback_entriesB");
   u00039 : constant Version_32 := 16#dc34d483#;
   pragma Export (C, u00039, "system__traceback_entriesS");
   u00040 : constant Version_32 := 16#b27c8a69#;
   pragma Export (C, u00040, "system__traceback__symbolicB");
   u00041 : constant Version_32 := 16#140ceb78#;
   pragma Export (C, u00041, "system__traceback__symbolicS");
   u00042 : constant Version_32 := 16#179d7d28#;
   pragma Export (C, u00042, "ada__containersS");
   u00043 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00043, "ada__exceptions__tracebackB");
   u00044 : constant Version_32 := 16#26ed0985#;
   pragma Export (C, u00044, "ada__exceptions__tracebackS");
   u00045 : constant Version_32 := 16#9111f9c1#;
   pragma Export (C, u00045, "interfacesS");
   u00046 : constant Version_32 := 16#0390ef72#;
   pragma Export (C, u00046, "interfaces__cB");
   u00047 : constant Version_32 := 16#1a6d7811#;
   pragma Export (C, u00047, "interfaces__cS");
   u00048 : constant Version_32 := 16#0978786d#;
   pragma Export (C, u00048, "system__bounded_stringsB");
   u00049 : constant Version_32 := 16#63d54a16#;
   pragma Export (C, u00049, "system__bounded_stringsS");
   u00050 : constant Version_32 := 16#9f0c0c80#;
   pragma Export (C, u00050, "system__crtlS");
   u00051 : constant Version_32 := 16#a604bd9c#;
   pragma Export (C, u00051, "system__dwarf_linesB");
   u00052 : constant Version_32 := 16#f38e5e19#;
   pragma Export (C, u00052, "system__dwarf_linesS");
   u00053 : constant Version_32 := 16#5b4659fa#;
   pragma Export (C, u00053, "ada__charactersS");
   u00054 : constant Version_32 := 16#9de61c25#;
   pragma Export (C, u00054, "ada__characters__handlingB");
   u00055 : constant Version_32 := 16#729cc5db#;
   pragma Export (C, u00055, "ada__characters__handlingS");
   u00056 : constant Version_32 := 16#cde9ea2d#;
   pragma Export (C, u00056, "ada__characters__latin_1S");
   u00057 : constant Version_32 := 16#e6d4fa36#;
   pragma Export (C, u00057, "ada__stringsS");
   u00058 : constant Version_32 := 16#c5e1e773#;
   pragma Export (C, u00058, "ada__strings__mapsB");
   u00059 : constant Version_32 := 16#6feaa257#;
   pragma Export (C, u00059, "ada__strings__mapsS");
   u00060 : constant Version_32 := 16#b451a498#;
   pragma Export (C, u00060, "system__bit_opsB");
   u00061 : constant Version_32 := 16#d9dbc733#;
   pragma Export (C, u00061, "system__bit_opsS");
   u00062 : constant Version_32 := 16#b459efcb#;
   pragma Export (C, u00062, "ada__strings__maps__constantsS");
   u00063 : constant Version_32 := 16#a0d3d22b#;
   pragma Export (C, u00063, "system__address_imageB");
   u00064 : constant Version_32 := 16#b5c4f635#;
   pragma Export (C, u00064, "system__address_imageS");
   u00065 : constant Version_32 := 16#7da15eb1#;
   pragma Export (C, u00065, "system__img_unsS");
   u00066 : constant Version_32 := 16#20ec7aa3#;
   pragma Export (C, u00066, "system__ioB");
   u00067 : constant Version_32 := 16#8a6a9c40#;
   pragma Export (C, u00067, "system__ioS");
   u00068 : constant Version_32 := 16#e15ca368#;
   pragma Export (C, u00068, "system__mmapB");
   u00069 : constant Version_32 := 16#da9a152c#;
   pragma Export (C, u00069, "system__mmapS");
   u00070 : constant Version_32 := 16#367911c4#;
   pragma Export (C, u00070, "ada__io_exceptionsS");
   u00071 : constant Version_32 := 16#dd82c35a#;
   pragma Export (C, u00071, "system__mmap__os_interfaceB");
   u00072 : constant Version_32 := 16#37fd3b64#;
   pragma Export (C, u00072, "system__mmap__os_interfaceS");
   u00073 : constant Version_32 := 16#c8a05a18#;
   pragma Export (C, u00073, "system__mmap__unixS");
   u00074 : constant Version_32 := 16#29c68ba2#;
   pragma Export (C, u00074, "system__os_libB");
   u00075 : constant Version_32 := 16#ee44bb50#;
   pragma Export (C, u00075, "system__os_libS");
   u00076 : constant Version_32 := 16#94d23d25#;
   pragma Export (C, u00076, "system__atomic_operations__test_and_setB");
   u00077 : constant Version_32 := 16#57acee8e#;
   pragma Export (C, u00077, "system__atomic_operations__test_and_setS");
   u00078 : constant Version_32 := 16#d34b112a#;
   pragma Export (C, u00078, "system__atomic_operationsS");
   u00079 : constant Version_32 := 16#553a519e#;
   pragma Export (C, u00079, "system__atomic_primitivesB");
   u00080 : constant Version_32 := 16#5f776048#;
   pragma Export (C, u00080, "system__atomic_primitivesS");
   u00081 : constant Version_32 := 16#b98923bf#;
   pragma Export (C, u00081, "system__case_utilB");
   u00082 : constant Version_32 := 16#db3bbc5a#;
   pragma Export (C, u00082, "system__case_utilS");
   u00083 : constant Version_32 := 16#256dbbe5#;
   pragma Export (C, u00083, "system__stringsB");
   u00084 : constant Version_32 := 16#8faa6b17#;
   pragma Export (C, u00084, "system__stringsS");
   u00085 : constant Version_32 := 16#edf7b7b1#;
   pragma Export (C, u00085, "system__object_readerB");
   u00086 : constant Version_32 := 16#87571f07#;
   pragma Export (C, u00086, "system__object_readerS");
   u00087 : constant Version_32 := 16#75406883#;
   pragma Export (C, u00087, "system__val_lliS");
   u00088 : constant Version_32 := 16#838eea00#;
   pragma Export (C, u00088, "system__val_lluS");
   u00089 : constant Version_32 := 16#47d9a892#;
   pragma Export (C, u00089, "system__sparkS");
   u00090 : constant Version_32 := 16#a571a4dc#;
   pragma Export (C, u00090, "system__spark__cut_operationsB");
   u00091 : constant Version_32 := 16#629c0fb7#;
   pragma Export (C, u00091, "system__spark__cut_operationsS");
   u00092 : constant Version_32 := 16#1bac5121#;
   pragma Export (C, u00092, "system__val_utilB");
   u00093 : constant Version_32 := 16#b851cf14#;
   pragma Export (C, u00093, "system__val_utilS");
   u00094 : constant Version_32 := 16#bad10b33#;
   pragma Export (C, u00094, "system__exception_tracesB");
   u00095 : constant Version_32 := 16#f8b00269#;
   pragma Export (C, u00095, "system__exception_tracesS");
   u00096 : constant Version_32 := 16#fd158a37#;
   pragma Export (C, u00096, "system__wch_conB");
   u00097 : constant Version_32 := 16#cd2b486c#;
   pragma Export (C, u00097, "system__wch_conS");
   u00098 : constant Version_32 := 16#5c289972#;
   pragma Export (C, u00098, "system__wch_stwB");
   u00099 : constant Version_32 := 16#e03a646d#;
   pragma Export (C, u00099, "system__wch_stwS");
   u00100 : constant Version_32 := 16#7cd63de5#;
   pragma Export (C, u00100, "system__wch_cnvB");
   u00101 : constant Version_32 := 16#cbeb821c#;
   pragma Export (C, u00101, "system__wch_cnvS");
   u00102 : constant Version_32 := 16#e538de43#;
   pragma Export (C, u00102, "system__wch_jisB");
   u00103 : constant Version_32 := 16#7e5ce036#;
   pragma Export (C, u00103, "system__wch_jisS");
   u00104 : constant Version_32 := 16#d172d809#;
   pragma Export (C, u00104, "system__os_primitivesB");
   u00105 : constant Version_32 := 16#13d50ef9#;
   pragma Export (C, u00105, "system__os_primitivesS");
   u00106 : constant Version_32 := 16#c3b32edd#;
   pragma Export (C, u00106, "ada__containers__helpersB");
   u00107 : constant Version_32 := 16#444c93c2#;
   pragma Export (C, u00107, "ada__containers__helpersS");
   u00108 : constant Version_32 := 16#86c56e5a#;
   pragma Export (C, u00108, "ada__finalizationS");
   u00109 : constant Version_32 := 16#b4f41810#;
   pragma Export (C, u00109, "ada__streamsB");
   u00110 : constant Version_32 := 16#67e31212#;
   pragma Export (C, u00110, "ada__streamsS");
   u00111 : constant Version_32 := 16#a201b8c5#;
   pragma Export (C, u00111, "ada__strings__text_buffersB");
   u00112 : constant Version_32 := 16#a7cfd09b#;
   pragma Export (C, u00112, "ada__strings__text_buffersS");
   u00113 : constant Version_32 := 16#8b7604c4#;
   pragma Export (C, u00113, "ada__strings__utf_encodingB");
   u00114 : constant Version_32 := 16#c9e86997#;
   pragma Export (C, u00114, "ada__strings__utf_encodingS");
   u00115 : constant Version_32 := 16#bb780f45#;
   pragma Export (C, u00115, "ada__strings__utf_encoding__stringsB");
   u00116 : constant Version_32 := 16#b85ff4b6#;
   pragma Export (C, u00116, "ada__strings__utf_encoding__stringsS");
   u00117 : constant Version_32 := 16#d1d1ed0b#;
   pragma Export (C, u00117, "ada__strings__utf_encoding__wide_stringsB");
   u00118 : constant Version_32 := 16#5678478f#;
   pragma Export (C, u00118, "ada__strings__utf_encoding__wide_stringsS");
   u00119 : constant Version_32 := 16#c2b98963#;
   pragma Export (C, u00119, "ada__strings__utf_encoding__wide_wide_stringsB");
   u00120 : constant Version_32 := 16#d7af3358#;
   pragma Export (C, u00120, "ada__strings__utf_encoding__wide_wide_stringsS");
   u00121 : constant Version_32 := 16#0d5e09a4#;
   pragma Export (C, u00121, "ada__tagsB");
   u00122 : constant Version_32 := 16#2a9756e0#;
   pragma Export (C, u00122, "ada__tagsS");
   u00123 : constant Version_32 := 16#3548d972#;
   pragma Export (C, u00123, "system__htableB");
   u00124 : constant Version_32 := 16#95f133e4#;
   pragma Export (C, u00124, "system__htableS");
   u00125 : constant Version_32 := 16#1f1abe38#;
   pragma Export (C, u00125, "system__string_hashB");
   u00126 : constant Version_32 := 16#32b4b39b#;
   pragma Export (C, u00126, "system__string_hashS");
   u00127 : constant Version_32 := 16#05222263#;
   pragma Export (C, u00127, "system__put_imagesB");
   u00128 : constant Version_32 := 16#08866c10#;
   pragma Export (C, u00128, "system__put_imagesS");
   u00129 : constant Version_32 := 16#22b9eb9f#;
   pragma Export (C, u00129, "ada__strings__text_buffers__utilsB");
   u00130 : constant Version_32 := 16#89062ac3#;
   pragma Export (C, u00130, "ada__strings__text_buffers__utilsS");
   u00131 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00131, "system__finalization_rootB");
   u00132 : constant Version_32 := 16#5bda189f#;
   pragma Export (C, u00132, "system__finalization_rootS");
   u00133 : constant Version_32 := 16#52627794#;
   pragma Export (C, u00133, "system__atomic_countersB");
   u00134 : constant Version_32 := 16#c83084cc#;
   pragma Export (C, u00134, "system__atomic_countersS");
   u00135 : constant Version_32 := 16#8baa45c6#;
   pragma Export (C, u00135, "ada__directories__hierarchical_file_namesB");
   u00136 : constant Version_32 := 16#34d5eeb2#;
   pragma Export (C, u00136, "ada__directories__hierarchical_file_namesS");
   u00137 : constant Version_32 := 16#ab4ad33a#;
   pragma Export (C, u00137, "ada__directories__validityB");
   u00138 : constant Version_32 := 16#0877bcae#;
   pragma Export (C, u00138, "ada__directories__validityS");
   u00139 : constant Version_32 := 16#603adc29#;
   pragma Export (C, u00139, "ada__strings__fixedB");
   u00140 : constant Version_32 := 16#b4492da2#;
   pragma Export (C, u00140, "ada__strings__fixedS");
   u00141 : constant Version_32 := 16#fb589256#;
   pragma Export (C, u00141, "ada__strings__searchB");
   u00142 : constant Version_32 := 16#a44727a7#;
   pragma Export (C, u00142, "ada__strings__searchS");
   u00143 : constant Version_32 := 16#4b810764#;
   pragma Export (C, u00143, "ada__strings__unboundedB");
   u00144 : constant Version_32 := 16#850187aa#;
   pragma Export (C, u00144, "ada__strings__unboundedS");
   u00145 : constant Version_32 := 16#ec48c658#;
   pragma Export (C, u00145, "system__compare_array_unsigned_8B");
   u00146 : constant Version_32 := 16#84cef56c#;
   pragma Export (C, u00146, "system__compare_array_unsigned_8S");
   u00147 : constant Version_32 := 16#74e358eb#;
   pragma Export (C, u00147, "system__address_operationsB");
   u00148 : constant Version_32 := 16#6a1c47af#;
   pragma Export (C, u00148, "system__address_operationsS");
   u00149 : constant Version_32 := 16#d79db92c#;
   pragma Export (C, u00149, "system__return_stackS");
   u00150 : constant Version_32 := 16#8356fb7a#;
   pragma Export (C, u00150, "system__stream_attributesB");
   u00151 : constant Version_32 := 16#5e1f8be2#;
   pragma Export (C, u00151, "system__stream_attributesS");
   u00152 : constant Version_32 := 16#4ea7f13e#;
   pragma Export (C, u00152, "system__stream_attributes__xdrB");
   u00153 : constant Version_32 := 16#14c199f1#;
   pragma Export (C, u00153, "system__stream_attributes__xdrS");
   u00154 : constant Version_32 := 16#d71ab463#;
   pragma Export (C, u00154, "system__fat_fltS");
   u00155 : constant Version_32 := 16#f128bd6e#;
   pragma Export (C, u00155, "system__fat_lfltS");
   u00156 : constant Version_32 := 16#8bf81384#;
   pragma Export (C, u00156, "system__fat_llfS");
   u00157 : constant Version_32 := 16#a6658f08#;
   pragma Export (C, u00157, "system__file_attributesS");
   u00158 : constant Version_32 := 16#b4f669b5#;
   pragma Export (C, u00158, "system__os_constantsS");
   u00159 : constant Version_32 := 16#f74fab1c#;
   pragma Export (C, u00159, "system__file_ioB");
   u00160 : constant Version_32 := 16#72673e49#;
   pragma Export (C, u00160, "system__file_ioS");
   u00161 : constant Version_32 := 16#1cacf006#;
   pragma Export (C, u00161, "interfaces__c_streamsB");
   u00162 : constant Version_32 := 16#d07279c2#;
   pragma Export (C, u00162, "interfaces__c_streamsS");
   u00163 : constant Version_32 := 16#9881056b#;
   pragma Export (C, u00163, "system__file_control_blockS");
   u00164 : constant Version_32 := 16#b9e0ae25#;
   pragma Export (C, u00164, "system__finalization_mastersB");
   u00165 : constant Version_32 := 16#a6db6891#;
   pragma Export (C, u00165, "system__finalization_mastersS");
   u00166 : constant Version_32 := 16#35d6ef80#;
   pragma Export (C, u00166, "system__storage_poolsB");
   u00167 : constant Version_32 := 16#8e431254#;
   pragma Export (C, u00167, "system__storage_poolsS");
   u00168 : constant Version_32 := 16#8f8e85c2#;
   pragma Export (C, u00168, "system__regexpB");
   u00169 : constant Version_32 := 16#371accc3#;
   pragma Export (C, u00169, "system__regexpS");
   u00170 : constant Version_32 := 16#dc72c666#;
   pragma Export (C, u00170, "ada__real_timeB");
   u00171 : constant Version_32 := 16#c981504e#;
   pragma Export (C, u00171, "ada__real_timeS");
   u00172 : constant Version_32 := 16#d0926081#;
   pragma Export (C, u00172, "system__taskingB");
   u00173 : constant Version_32 := 16#830ed04a#;
   pragma Export (C, u00173, "system__taskingS");
   u00174 : constant Version_32 := 16#be15cda8#;
   pragma Export (C, u00174, "system__task_primitivesS");
   u00175 : constant Version_32 := 16#72136539#;
   pragma Export (C, u00175, "system__os_interfaceB");
   u00176 : constant Version_32 := 16#6a1d7316#;
   pragma Export (C, u00176, "system__os_interfaceS");
   u00177 : constant Version_32 := 16#bff98b5c#;
   pragma Export (C, u00177, "system__linuxS");
   u00178 : constant Version_32 := 16#16de8de8#;
   pragma Export (C, u00178, "system__task_primitives__operationsB");
   u00179 : constant Version_32 := 16#1a81091a#;
   pragma Export (C, u00179, "system__task_primitives__operationsS");
   u00180 : constant Version_32 := 16#9ebeb40e#;
   pragma Export (C, u00180, "system__interrupt_managementB");
   u00181 : constant Version_32 := 16#f000fc35#;
   pragma Export (C, u00181, "system__interrupt_managementS");
   u00182 : constant Version_32 := 16#3053a91b#;
   pragma Export (C, u00182, "system__multiprocessorsB");
   u00183 : constant Version_32 := 16#2c84f47c#;
   pragma Export (C, u00183, "system__multiprocessorsS");
   u00184 : constant Version_32 := 16#4ee862d1#;
   pragma Export (C, u00184, "system__task_infoB");
   u00185 : constant Version_32 := 16#a250823b#;
   pragma Export (C, u00185, "system__task_infoS");
   u00186 : constant Version_32 := 16#0e54f198#;
   pragma Export (C, u00186, "system__tasking__debugB");
   u00187 : constant Version_32 := 16#aeb4df49#;
   pragma Export (C, u00187, "system__tasking__debugS");
   u00188 : constant Version_32 := 16#ca878138#;
   pragma Export (C, u00188, "system__concat_2B");
   u00189 : constant Version_32 := 16#a1d318f8#;
   pragma Export (C, u00189, "system__concat_2S");
   u00190 : constant Version_32 := 16#752a67ed#;
   pragma Export (C, u00190, "system__concat_3B");
   u00191 : constant Version_32 := 16#9e5272ad#;
   pragma Export (C, u00191, "system__concat_3S");
   u00192 : constant Version_32 := 16#5eeebe35#;
   pragma Export (C, u00192, "system__img_lliS");
   u00193 : constant Version_32 := 16#3066cab0#;
   pragma Export (C, u00193, "system__stack_usageB");
   u00194 : constant Version_32 := 16#4a68f31e#;
   pragma Export (C, u00194, "system__stack_usageS");
   u00195 : constant Version_32 := 16#a0ad5bf9#;
   pragma Export (C, u00195, "ada__streams__stream_ioB");
   u00196 : constant Version_32 := 16#5b183aea#;
   pragma Export (C, u00196, "ada__streams__stream_ioS");
   u00197 : constant Version_32 := 16#5de653db#;
   pragma Export (C, u00197, "system__communicationB");
   u00198 : constant Version_32 := 16#bd407e32#;
   pragma Export (C, u00198, "system__communicationS");
   u00199 : constant Version_32 := 16#adb69b3b#;
   pragma Export (C, u00199, "ada__strings__text_buffers__unboundedB");
   u00200 : constant Version_32 := 16#342cb7b4#;
   pragma Export (C, u00200, "ada__strings__text_buffers__unboundedS");
   u00201 : constant Version_32 := 16#d06988db#;
   pragma Export (C, u00201, "ada__strings__utf_encoding__conversionsB");
   u00202 : constant Version_32 := 16#5d3ea779#;
   pragma Export (C, u00202, "ada__strings__utf_encoding__conversionsS");
   u00203 : constant Version_32 := 16#2170d2a2#;
   pragma Export (C, u00203, "ada__text_ioB");
   u00204 : constant Version_32 := 16#0277f011#;
   pragma Export (C, u00204, "ada__text_ioS");
   u00205 : constant Version_32 := 16#4377c88d#;
   pragma Export (C, u00205, "extensible_httpB");
   u00206 : constant Version_32 := 16#329d8cbc#;
   pragma Export (C, u00206, "extensible_httpS");
   u00207 : constant Version_32 := 16#45cbb099#;
   pragma Export (C, u00207, "system__strings__stream_opsB");
   u00208 : constant Version_32 := 16#40062c5a#;
   pragma Export (C, u00208, "system__strings__stream_opsS");
   u00209 : constant Version_32 := 16#4037cf7b#;
   pragma Export (C, u00209, "system__val_enum_8S");
   u00210 : constant Version_32 := 16#aa0160a2#;
   pragma Export (C, u00210, "system__val_intS");
   u00211 : constant Version_32 := 16#5da6ebca#;
   pragma Export (C, u00211, "system__val_unsS");
   u00212 : constant Version_32 := 16#f4ca97ce#;
   pragma Export (C, u00212, "ada__containers__red_black_treesS");
   u00213 : constant Version_32 := 16#3f686d0f#;
   pragma Export (C, u00213, "system__pool_globalB");
   u00214 : constant Version_32 := 16#a07c1f1e#;
   pragma Export (C, u00214, "system__pool_globalS");
   u00215 : constant Version_32 := 16#8f2423cb#;
   pragma Export (C, u00215, "system__memoryB");
   u00216 : constant Version_32 := 16#0cbcf715#;
   pragma Export (C, u00216, "system__memoryS");
   u00217 : constant Version_32 := 16#8b0ace09#;
   pragma Export (C, u00217, "system__storage_pools__subpoolsB");
   u00218 : constant Version_32 := 16#50a294f1#;
   pragma Export (C, u00218, "system__storage_pools__subpoolsS");
   u00219 : constant Version_32 := 16#252fe4d9#;
   pragma Export (C, u00219, "system__storage_pools__subpools__finalizationB");
   u00220 : constant Version_32 := 16#562129f7#;
   pragma Export (C, u00220, "system__storage_pools__subpools__finalizationS");
   u00221 : constant Version_32 := 16#b5988c27#;
   pragma Export (C, u00221, "gnatS");
   u00222 : constant Version_32 := 16#dbb84d34#;
   pragma Export (C, u00222, "gnat__command_lineB");
   u00223 : constant Version_32 := 16#556a5ffb#;
   pragma Export (C, u00223, "gnat__command_lineS");
   u00224 : constant Version_32 := 16#c5e7726a#;
   pragma Export (C, u00224, "gnat__directory_operationsB");
   u00225 : constant Version_32 := 16#2a2d48a6#;
   pragma Export (C, u00225, "gnat__directory_operationsS");
   u00226 : constant Version_32 := 16#1a69b526#;
   pragma Export (C, u00226, "gnat__os_libS");
   u00227 : constant Version_32 := 16#fe7a0f2d#;
   pragma Export (C, u00227, "ada__command_lineB");
   u00228 : constant Version_32 := 16#3cdef8c9#;
   pragma Export (C, u00228, "ada__command_lineS");
   u00229 : constant Version_32 := 16#40fe4806#;
   pragma Export (C, u00229, "gnat__regexpS");
   u00230 : constant Version_32 := 16#2b19e51a#;
   pragma Export (C, u00230, "gnat__stringsS");
   u00231 : constant Version_32 := 16#5da3d2ff#;
   pragma Export (C, u00231, "gnat__socketsB");
   u00232 : constant Version_32 := 16#1eb27ed2#;
   pragma Export (C, u00232, "gnat__socketsS");
   u00233 : constant Version_32 := 16#17f10572#;
   pragma Export (C, u00233, "gnat__sockets__linker_optionsS");
   u00234 : constant Version_32 := 16#0f581d28#;
   pragma Export (C, u00234, "gnat__sockets__pollB");
   u00235 : constant Version_32 := 16#00e6ee27#;
   pragma Export (C, u00235, "gnat__sockets__pollS");
   u00236 : constant Version_32 := 16#6521cea8#;
   pragma Export (C, u00236, "gnat__sockets__thinB");
   u00237 : constant Version_32 := 16#11cf7d13#;
   pragma Export (C, u00237, "gnat__sockets__thinS");
   u00238 : constant Version_32 := 16#87ec1338#;
   pragma Export (C, u00238, "ada__calendar__delaysB");
   u00239 : constant Version_32 := 16#8aaaec5e#;
   pragma Export (C, u00239, "ada__calendar__delaysS");
   u00240 : constant Version_32 := 16#485b8267#;
   pragma Export (C, u00240, "gnat__task_lockS");
   u00241 : constant Version_32 := 16#7d808794#;
   pragma Export (C, u00241, "system__task_lockB");
   u00242 : constant Version_32 := 16#75a25c61#;
   pragma Export (C, u00242, "system__task_lockS");
   u00243 : constant Version_32 := 16#94835be8#;
   pragma Export (C, u00243, "gnat__sockets__thin_commonB");
   u00244 : constant Version_32 := 16#f02086ee#;
   pragma Export (C, u00244, "gnat__sockets__thin_commonS");
   u00245 : constant Version_32 := 16#58c21abc#;
   pragma Export (C, u00245, "interfaces__c__stringsB");
   u00246 : constant Version_32 := 16#fecad76a#;
   pragma Export (C, u00246, "interfaces__c__stringsS");
   u00247 : constant Version_32 := 16#0943a5da#;
   pragma Export (C, u00247, "system__arith_64B");
   u00248 : constant Version_32 := 16#248e545a#;
   pragma Export (C, u00248, "system__arith_64S");
   u00249 : constant Version_32 := 16#22d1a9c4#;
   pragma Export (C, u00249, "system__tasking__protected_objectsB");
   u00250 : constant Version_32 := 16#4712e4f3#;
   pragma Export (C, u00250, "system__tasking__protected_objectsS");
   u00251 : constant Version_32 := 16#4dea734d#;
   pragma Export (C, u00251, "system__soft_links__taskingB");
   u00252 : constant Version_32 := 16#917fc4d2#;
   pragma Export (C, u00252, "system__soft_links__taskingS");
   u00253 : constant Version_32 := 16#3880736e#;
   pragma Export (C, u00253, "ada__exceptions__is_null_occurrenceB");
   u00254 : constant Version_32 := 16#2f594863#;
   pragma Export (C, u00254, "ada__exceptions__is_null_occurrenceS");
   u00255 : constant Version_32 := 16#472ea76a#;
   pragma Export (C, u00255, "system__tasking__protected_objects__entriesB");
   u00256 : constant Version_32 := 16#7daf93e7#;
   pragma Export (C, u00256, "system__tasking__protected_objects__entriesS");
   u00257 : constant Version_32 := 16#49c205ec#;
   pragma Export (C, u00257, "system__restrictionsB");
   u00258 : constant Version_32 := 16#b94b399e#;
   pragma Export (C, u00258, "system__restrictionsS");
   u00259 : constant Version_32 := 16#101444ca#;
   pragma Export (C, u00259, "system__tasking__initializationB");
   u00260 : constant Version_32 := 16#ae31fcba#;
   pragma Export (C, u00260, "system__tasking__initializationS");
   u00261 : constant Version_32 := 16#3909463c#;
   pragma Export (C, u00261, "system__tasking__task_attributesB");
   u00262 : constant Version_32 := 16#13eccb70#;
   pragma Export (C, u00262, "system__tasking__task_attributesS");
   u00263 : constant Version_32 := 16#95ec39a0#;
   pragma Export (C, u00263, "system__tasking__protected_objects__operationsB");
   u00264 : constant Version_32 := 16#74b8b389#;
   pragma Export (C, u00264, "system__tasking__protected_objects__operationsS");
   u00265 : constant Version_32 := 16#c1f64448#;
   pragma Export (C, u00265, "system__tasking__entry_callsB");
   u00266 : constant Version_32 := 16#3150fd12#;
   pragma Export (C, u00266, "system__tasking__entry_callsS");
   u00267 : constant Version_32 := 16#91c1d62b#;
   pragma Export (C, u00267, "system__tasking__queuingB");
   u00268 : constant Version_32 := 16#10de7412#;
   pragma Export (C, u00268, "system__tasking__queuingS");
   u00269 : constant Version_32 := 16#0044c253#;
   pragma Export (C, u00269, "system__tasking__utilitiesB");
   u00270 : constant Version_32 := 16#e7b7a611#;
   pragma Export (C, u00270, "system__tasking__utilitiesS");
   u00271 : constant Version_32 := 16#4857f38e#;
   pragma Export (C, u00271, "system__tasking__rendezvousB");
   u00272 : constant Version_32 := 16#ca844580#;
   pragma Export (C, u00272, "system__tasking__rendezvousS");
   u00273 : constant Version_32 := 16#67dfd22f#;
   pragma Export (C, u00273, "system__tasking__stagesB");
   u00274 : constant Version_32 := 16#916de0b2#;
   pragma Export (C, u00274, "system__tasking__stagesS");
   u00275 : constant Version_32 := 16#2d236812#;
   pragma Export (C, u00275, "ada__task_initializationB");
   u00276 : constant Version_32 := 16#d7b0c315#;
   pragma Export (C, u00276, "ada__task_initializationS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.latin_1%s
   --  ada.task_initialization%s
   --  ada.task_initialization%b
   --  interfaces%s
   --  system%s
   --  system.address_operations%s
   --  system.address_operations%b
   --  system.atomic_operations%s
   --  system.io%s
   --  system.io%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.os_primitives%s
   --  system.os_primitives%b
   --  system.restrictions%s
   --  system.restrictions%b
   --  system.spark%s
   --  system.spark.cut_operations%s
   --  system.spark.cut_operations%b
   --  system.storage_elements%s
   --  system.return_stack%s
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%s
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  system.unsigned_types%s
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%s
   --  system.wch_cnv%b
   --  system.compare_array_unsigned_8%s
   --  system.compare_array_unsigned_8%b
   --  system.concat_2%s
   --  system.concat_2%b
   --  system.concat_3%s
   --  system.concat_3%b
   --  system.traceback%s
   --  system.traceback%b
   --  ada.characters.handling%s
   --  system.atomic_operations.test_and_set%s
   --  system.case_util%s
   --  system.os_lib%s
   --  system.secondary_stack%s
   --  system.standard_library%s
   --  ada.exceptions%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.soft_links%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_llu%s
   --  system.val_lli%s
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  ada.exceptions.traceback%s
   --  ada.exceptions.traceback%b
   --  system.address_image%s
   --  system.address_image%b
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  system.bounded_strings%s
   --  system.bounded_strings%b
   --  system.case_util%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.containers%s
   --  ada.io_exceptions%s
   --  ada.numerics%s
   --  ada.numerics.big_numbers%s
   --  ada.strings%s
   --  ada.strings.maps%s
   --  ada.strings.maps%b
   --  ada.strings.maps.constants%s
   --  interfaces.c%s
   --  interfaces.c%b
   --  system.atomic_primitives%s
   --  system.atomic_primitives%b
   --  system.exceptions%s
   --  system.exceptions.machine%s
   --  system.exceptions.machine%b
   --  ada.characters.handling%b
   --  system.atomic_operations.test_and_set%b
   --  system.exception_traces%s
   --  system.exception_traces%b
   --  system.img_int%s
   --  system.img_uns%s
   --  system.memory%s
   --  system.memory%b
   --  system.mmap%s
   --  system.mmap.os_interface%s
   --  system.mmap%b
   --  system.mmap.unix%s
   --  system.mmap.os_interface%b
   --  system.object_reader%s
   --  system.object_reader%b
   --  system.dwarf_lines%s
   --  system.dwarf_lines%b
   --  system.os_lib%b
   --  system.secondary_stack%b
   --  system.soft_links.initialize%s
   --  system.soft_links.initialize%b
   --  system.soft_links%b
   --  system.standard_library%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  ada.exceptions%b
   --  ada.command_line%s
   --  ada.command_line%b
   --  ada.exceptions.is_null_occurrence%s
   --  ada.exceptions.is_null_occurrence%b
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.strings.fixed%s
   --  ada.strings.fixed%b
   --  ada.strings.utf_encoding%s
   --  ada.strings.utf_encoding%b
   --  ada.strings.utf_encoding.conversions%s
   --  ada.strings.utf_encoding.conversions%b
   --  ada.strings.utf_encoding.strings%s
   --  ada.strings.utf_encoding.strings%b
   --  ada.strings.utf_encoding.wide_strings%s
   --  ada.strings.utf_encoding.wide_strings%b
   --  ada.strings.utf_encoding.wide_wide_strings%s
   --  ada.strings.utf_encoding.wide_wide_strings%b
   --  ada.tags%s
   --  ada.tags%b
   --  ada.strings.text_buffers%s
   --  ada.strings.text_buffers%b
   --  ada.strings.text_buffers.utils%s
   --  ada.strings.text_buffers.utils%b
   --  gnat%s
   --  gnat.os_lib%s
   --  gnat.strings%s
   --  interfaces.c.strings%s
   --  interfaces.c.strings%b
   --  system.arith_64%s
   --  system.arith_64%b
   --  system.atomic_counters%s
   --  system.atomic_counters%b
   --  system.fat_flt%s
   --  system.fat_lflt%s
   --  system.fat_llf%s
   --  system.linux%s
   --  system.multiprocessors%s
   --  system.multiprocessors%b
   --  system.os_constants%s
   --  system.os_interface%s
   --  system.os_interface%b
   --  system.put_images%s
   --  system.put_images%b
   --  ada.streams%s
   --  ada.streams%b
   --  system.communication%s
   --  system.communication%b
   --  system.file_control_block%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  ada.containers.helpers%s
   --  ada.containers.helpers%b
   --  ada.containers.red_black_trees%s
   --  system.file_io%s
   --  system.file_io%b
   --  ada.streams.stream_io%s
   --  ada.streams.stream_io%b
   --  system.stack_usage%s
   --  system.stack_usage%b
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  system.finalization_masters%s
   --  system.finalization_masters%b
   --  ada.strings.text_buffers.unbounded%s
   --  ada.strings.text_buffers.unbounded%b
   --  system.storage_pools.subpools%s
   --  system.storage_pools.subpools.finalization%s
   --  system.storage_pools.subpools.finalization%b
   --  system.storage_pools.subpools%b
   --  system.stream_attributes%s
   --  system.stream_attributes.xdr%s
   --  system.stream_attributes.xdr%b
   --  system.stream_attributes%b
   --  ada.strings.unbounded%s
   --  ada.strings.unbounded%b
   --  system.task_info%s
   --  system.task_info%b
   --  system.task_lock%s
   --  system.task_lock%b
   --  gnat.task_lock%s
   --  system.task_primitives%s
   --  system.interrupt_management%s
   --  system.interrupt_management%b
   --  system.val_enum_8%s
   --  system.val_uns%s
   --  system.val_int%s
   --  ada.calendar%s
   --  ada.calendar%b
   --  ada.calendar.delays%s
   --  ada.calendar.delays%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  gnat.directory_operations%s
   --  gnat.directory_operations%b
   --  system.file_attributes%s
   --  system.img_lli%s
   --  system.tasking%s
   --  system.task_primitives.operations%s
   --  system.tasking.debug%s
   --  system.tasking.debug%b
   --  system.task_primitives.operations%b
   --  system.tasking%b
   --  ada.real_time%s
   --  ada.real_time%b
   --  system.pool_global%s
   --  system.pool_global%b
   --  gnat.sockets%s
   --  gnat.sockets.linker_options%s
   --  gnat.sockets.poll%s
   --  gnat.sockets.thin_common%s
   --  gnat.sockets.thin_common%b
   --  gnat.sockets.thin%s
   --  gnat.sockets.thin%b
   --  gnat.sockets%b
   --  gnat.sockets.poll%b
   --  system.regexp%s
   --  system.regexp%b
   --  ada.directories%s
   --  ada.directories.hierarchical_file_names%s
   --  ada.directories.validity%s
   --  ada.directories.validity%b
   --  ada.directories%b
   --  ada.directories.hierarchical_file_names%b
   --  gnat.regexp%s
   --  gnat.command_line%s
   --  gnat.command_line%b
   --  system.soft_links.tasking%s
   --  system.soft_links.tasking%b
   --  system.strings.stream_ops%s
   --  system.strings.stream_ops%b
   --  system.tasking.initialization%s
   --  system.tasking.task_attributes%s
   --  system.tasking.task_attributes%b
   --  system.tasking.initialization%b
   --  system.tasking.protected_objects%s
   --  system.tasking.protected_objects%b
   --  system.tasking.protected_objects.entries%s
   --  system.tasking.protected_objects.entries%b
   --  system.tasking.queuing%s
   --  system.tasking.queuing%b
   --  system.tasking.utilities%s
   --  system.tasking.utilities%b
   --  system.tasking.entry_calls%s
   --  system.tasking.rendezvous%s
   --  system.tasking.protected_objects.operations%s
   --  system.tasking.protected_objects.operations%b
   --  system.tasking.entry_calls%b
   --  system.tasking.rendezvous%b
   --  system.tasking.stages%s
   --  system.tasking.stages%b
   --  extensible_http%s
   --  extensible_http%b
   --  basic_http_server%b
   --  END ELABORATION ORDER

end ada_main;
