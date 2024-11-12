pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__basic_http_server.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__basic_http_server.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E075 : Short_Integer; pragma Import (Ada, E075, "system__os_lib_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "ada__exceptions_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E026 : Short_Integer; pragma Import (Ada, E026, "system__exception_table_E");
   E042 : Short_Integer; pragma Import (Ada, E042, "ada__containers_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "ada__io_exceptions_E");
   E033 : Short_Integer; pragma Import (Ada, E033, "ada__numerics_E");
   E057 : Short_Integer; pragma Import (Ada, E057, "ada__strings_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__strings__maps_E");
   E062 : Short_Integer; pragma Import (Ada, E062, "ada__strings__maps__constants_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "interfaces__c_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exceptions_E");
   E086 : Short_Integer; pragma Import (Ada, E086, "system__object_reader_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "system__dwarf_lines_E");
   E022 : Short_Integer; pragma Import (Ada, E022, "system__soft_links__initialize_E");
   E041 : Short_Integer; pragma Import (Ada, E041, "system__traceback__symbolic_E");
   E114 : Short_Integer; pragma Import (Ada, E114, "ada__strings__utf_encoding_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "ada__tags_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "ada__strings__text_buffers_E");
   E221 : Short_Integer; pragma Import (Ada, E221, "gnat_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "interfaces__c__strings_E");
   E110 : Short_Integer; pragma Import (Ada, E110, "ada__streams_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "system__file_control_block_E");
   E132 : Short_Integer; pragma Import (Ada, E132, "system__finalization_root_E");
   E108 : Short_Integer; pragma Import (Ada, E108, "ada__finalization_E");
   E160 : Short_Integer; pragma Import (Ada, E160, "system__file_io_E");
   E196 : Short_Integer; pragma Import (Ada, E196, "ada__streams__stream_io_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "system__storage_pools_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "system__finalization_masters_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "ada__strings__text_buffers__unbounded_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "system__storage_pools__subpools_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "ada__strings__unbounded_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "system__task_info_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "ada__calendar_E");
   E239 : Short_Integer; pragma Import (Ada, E239, "ada__calendar__delays_E");
   E200 : Short_Integer; pragma Import (Ada, E200, "ada__text_io_E");
   E225 : Short_Integer; pragma Import (Ada, E225, "gnat__directory_operations_E");
   E179 : Short_Integer; pragma Import (Ada, E179, "system__task_primitives__operations_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "ada__real_time_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "system__pool_global_E");
   E232 : Short_Integer; pragma Import (Ada, E232, "gnat__sockets_E");
   E235 : Short_Integer; pragma Import (Ada, E235, "gnat__sockets__poll_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "gnat__sockets__thin_common_E");
   E237 : Short_Integer; pragma Import (Ada, E237, "gnat__sockets__thin_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "system__regexp_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__directories_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "gnat__command_line_E");
   E260 : Short_Integer; pragma Import (Ada, E260, "system__tasking__initialization_E");
   E250 : Short_Integer; pragma Import (Ada, E250, "system__tasking__protected_objects_E");
   E256 : Short_Integer; pragma Import (Ada, E256, "system__tasking__protected_objects__entries_E");
   E268 : Short_Integer; pragma Import (Ada, E268, "system__tasking__queuing_E");
   E274 : Short_Integer; pragma Import (Ada, E274, "system__tasking__stages_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "extensible_http_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E202 := E202 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "extensible_http__finalize_spec");
      begin
         F1;
      end;
      E256 := E256 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "ada__directories__finalize_body");
      begin
         E006 := E006 - 1;
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "ada__directories__finalize_spec");
      begin
         F4;
      end;
      E169 := E169 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "system__regexp__finalize_spec");
      begin
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "gnat__sockets__finalize_body");
      begin
         E232 := E232 - 1;
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "gnat__sockets__finalize_spec");
      begin
         F7;
      end;
      E214 := E214 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "system__pool_global__finalize_spec");
      begin
         F8;
      end;
      E200 := E200 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "ada__text_io__finalize_spec");
      begin
         F9;
      end;
      E144 := E144 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "ada__strings__unbounded__finalize_spec");
      begin
         F10;
      end;
      E218 := E218 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "system__storage_pools__subpools__finalize_spec");
      begin
         F11;
      end;
      E204 := E204 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "ada__strings__text_buffers__unbounded__finalize_spec");
      begin
         F12;
      end;
      E165 := E165 - 1;
      declare
         procedure F13;
         pragma Import (Ada, F13, "system__finalization_masters__finalize_spec");
      begin
         F13;
      end;
      E196 := E196 - 1;
      declare
         procedure F14;
         pragma Import (Ada, F14, "ada__streams__stream_io__finalize_spec");
      begin
         F14;
      end;
      declare
         procedure F15;
         pragma Import (Ada, F15, "system__file_io__finalize_body");
      begin
         E160 := E160 - 1;
         F15;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Exception_Tracebacks : Integer;
      pragma Import (C, Exception_Tracebacks, "__gl_exception_tracebacks");
      Exception_Tracebacks_Symbolic : Integer;
      pragma Import (C, Exception_Tracebacks_Symbolic, "__gl_exception_tracebacks_symbolic");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := '8';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, True, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (True, False, False, False, True, True, False, False, 
           True, False, False, True, True, True, True, False, 
           False, False, False, True, False, False, True, True, 
           False, True, True, False, True, True, True, True, 
           False, True, False, False, False, False, True, False, 
           True, True, False, True, False, True, True, False, 
           True, False, True, False, False, True, True, False, 
           True, False, False, False, False, True, False, False, 
           False, True, False, True, True, True, False, False, 
           True, False, True, True, True, False, True, True, 
           False, True, True, True, True, False, False, False, 
           False, False, False, False, False, True, False, True, 
           True, False, True, False),
         Count => (0, 0, 0, 1, 0, 2, 1, 0, 1, 0),
         Unknown => (False, False, False, False, False, False, True, False, True, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Exception_Tracebacks := 1;
      Exception_Tracebacks_Symbolic := 1;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E026 := E026 + 1;
      Ada.Containers'Elab_Spec;
      E042 := E042 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E070 := E070 + 1;
      Ada.Numerics'Elab_Spec;
      E033 := E033 + 1;
      Ada.Strings'Elab_Spec;
      E057 := E057 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E059 := E059 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E062 := E062 + 1;
      Interfaces.C'Elab_Spec;
      E047 := E047 + 1;
      System.Exceptions'Elab_Spec;
      E027 := E027 + 1;
      System.Object_Reader'Elab_Spec;
      E086 := E086 + 1;
      System.Dwarf_Lines'Elab_Spec;
      E052 := E052 + 1;
      System.Os_Lib'Elab_Body;
      E075 := E075 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E022 := E022 + 1;
      E015 := E015 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E041 := E041 + 1;
      E010 := E010 + 1;
      Ada.Strings.Utf_Encoding'Elab_Spec;
      E114 := E114 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E122 := E122 + 1;
      Ada.Strings.Text_Buffers'Elab_Spec;
      E112 := E112 + 1;
      Gnat'Elab_Spec;
      E221 := E221 + 1;
      Interfaces.C.Strings'Elab_Spec;
      E246 := E246 + 1;
      Ada.Streams'Elab_Spec;
      E110 := E110 + 1;
      System.File_Control_Block'Elab_Spec;
      E163 := E163 + 1;
      System.Finalization_Root'Elab_Spec;
      E132 := E132 + 1;
      Ada.Finalization'Elab_Spec;
      E108 := E108 + 1;
      System.File_Io'Elab_Body;
      E160 := E160 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E196 := E196 + 1;
      System.Storage_Pools'Elab_Spec;
      E167 := E167 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E165 := E165 + 1;
      Ada.Strings.Text_Buffers.Unbounded'Elab_Spec;
      E204 := E204 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E218 := E218 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E144 := E144 + 1;
      System.Task_Info'Elab_Spec;
      E185 := E185 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E008 := E008 + 1;
      Ada.Calendar.Delays'Elab_Body;
      E239 := E239 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E200 := E200 + 1;
      Gnat.Directory_Operations'Elab_Spec;
      Gnat.Directory_Operations'Elab_Body;
      E225 := E225 + 1;
      System.Task_Primitives.Operations'Elab_Body;
      E179 := E179 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E171 := E171 + 1;
      System.Pool_Global'Elab_Spec;
      E214 := E214 + 1;
      Gnat.Sockets'Elab_Spec;
      Gnat.Sockets.Thin_Common'Elab_Spec;
      E244 := E244 + 1;
      E237 := E237 + 1;
      Gnat.Sockets'Elab_Body;
      E232 := E232 + 1;
      E235 := E235 + 1;
      System.Regexp'Elab_Spec;
      E169 := E169 + 1;
      Ada.Directories'Elab_Spec;
      Ada.Directories'Elab_Body;
      E006 := E006 + 1;
      Gnat.Command_Line'Elab_Spec;
      Gnat.Command_Line'Elab_Body;
      E223 := E223 + 1;
      System.Tasking.Initialization'Elab_Body;
      E260 := E260 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E250 := E250 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E256 := E256 + 1;
      System.Tasking.Queuing'Elab_Body;
      E268 := E268 + 1;
      System.Tasking.Stages'Elab_Body;
      E274 := E274 + 1;
      Extensible_Http'Elab_Spec;
      Extensible_Http'Elab_Body;
      E202 := E202 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_basic_http_server");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /home/miko/basic_http_server/obj/development/basic_http_server.o
   --   -L/home/miko/basic_http_server/obj/development/
   --   -L/home/miko/basic_http_server/obj/development/
   --   -L/home/miko/extensible_http/lib/
   --   -L/home/miko/.local/share/alire/toolchains/gnat_native_14.2.1_06bb3def/lib/gcc/x86_64-pc-linux-gnu/14.2.0/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -lrt
   --   -lpthread
   --   -ldl
--  END Object file/option list   

end ada_main;
