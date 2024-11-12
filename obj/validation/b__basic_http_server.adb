pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__basic_http_server.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__basic_http_server.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E071 : Short_Integer; pragma Import (Ada, E071, "system__os_lib_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__exceptions_E");
   E011 : Short_Integer; pragma Import (Ada, E011, "system__soft_links_E");
   E022 : Short_Integer; pragma Import (Ada, E022, "system__exception_table_E");
   E038 : Short_Integer; pragma Import (Ada, E038, "ada__containers_E");
   E066 : Short_Integer; pragma Import (Ada, E066, "ada__io_exceptions_E");
   E029 : Short_Integer; pragma Import (Ada, E029, "ada__numerics_E");
   E053 : Short_Integer; pragma Import (Ada, E053, "ada__strings_E");
   E055 : Short_Integer; pragma Import (Ada, E055, "ada__strings__maps_E");
   E058 : Short_Integer; pragma Import (Ada, E058, "ada__strings__maps__constants_E");
   E043 : Short_Integer; pragma Import (Ada, E043, "interfaces__c_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exceptions_E");
   E082 : Short_Integer; pragma Import (Ada, E082, "system__object_reader_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "system__dwarf_lines_E");
   E018 : Short_Integer; pragma Import (Ada, E018, "system__soft_links__initialize_E");
   E037 : Short_Integer; pragma Import (Ada, E037, "system__traceback__symbolic_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "ada__assertions_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "ada__strings__utf_encoding_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "ada__tags_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "ada__strings__text_buffers_E");
   E199 : Short_Integer; pragma Import (Ada, E199, "gnat_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "interfaces__c__strings_E");
   E152 : Short_Integer; pragma Import (Ada, E152, "ada__streams_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "system__file_control_block_E");
   E158 : Short_Integer; pragma Import (Ada, E158, "system__finalization_root_E");
   E150 : Short_Integer; pragma Import (Ada, E150, "ada__finalization_E");
   E166 : Short_Integer; pragma Import (Ada, E166, "system__file_io_E");
   E160 : Short_Integer; pragma Import (Ada, E160, "system__storage_pools_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "system__finalization_masters_E");
   E145 : Short_Integer; pragma Import (Ada, E145, "ada__strings__text_buffers__unbounded_E");
   E196 : Short_Integer; pragma Import (Ada, E196, "system__storage_pools__subpools_E");
   E230 : Short_Integer; pragma Import (Ada, E230, "ada__strings__unbounded_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "system__task_info_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "ada__calendar_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "ada__calendar__delays_E");
   E162 : Short_Integer; pragma Import (Ada, E162, "ada__text_io_E");
   E110 : Short_Integer; pragma Import (Ada, E110, "system__task_primitives__operations_E");
   E101 : Short_Integer; pragma Import (Ada, E101, "ada__real_time_E");
   E224 : Short_Integer; pragma Import (Ada, E224, "system__pool_global_E");
   E201 : Short_Integer; pragma Import (Ada, E201, "gnat__sockets_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "gnat__sockets__poll_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "gnat__sockets__thin_common_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "gnat__sockets__thin_E");
   E245 : Short_Integer; pragma Import (Ada, E245, "system__tasking__initialization_E");
   E235 : Short_Integer; pragma Import (Ada, E235, "system__tasking__protected_objects_E");
   E241 : Short_Integer; pragma Import (Ada, E241, "system__tasking__protected_objects__entries_E");
   E253 : Short_Integer; pragma Import (Ada, E253, "system__tasking__queuing_E");
   E259 : Short_Integer; pragma Import (Ada, E259, "system__tasking__stages_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "extensible_http_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E169 := E169 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "extensible_http__finalize_spec");
      begin
         F1;
      end;
      E241 := E241 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "gnat__sockets__finalize_body");
      begin
         E201 := E201 - 1;
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "gnat__sockets__finalize_spec");
      begin
         F4;
      end;
      E224 := E224 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "system__pool_global__finalize_spec");
      begin
         F5;
      end;
      E162 := E162 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "ada__text_io__finalize_spec");
      begin
         F6;
      end;
      E230 := E230 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "ada__strings__unbounded__finalize_spec");
      begin
         F7;
      end;
      E196 := E196 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "system__storage_pools__subpools__finalize_spec");
      begin
         F8;
      end;
      E145 := E145 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "ada__strings__text_buffers__unbounded__finalize_spec");
      begin
         F9;
      end;
      E149 := E149 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "system__finalization_masters__finalize_spec");
      begin
         F10;
      end;
      declare
         procedure F11;
         pragma Import (Ada, F11, "system__file_io__finalize_body");
      begin
         E166 := E166 - 1;
         F11;
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
           False, False, False, False, False, False, True, False, 
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
      E022 := E022 + 1;
      Ada.Containers'Elab_Spec;
      E038 := E038 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E066 := E066 + 1;
      Ada.Numerics'Elab_Spec;
      E029 := E029 + 1;
      Ada.Strings'Elab_Spec;
      E053 := E053 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E055 := E055 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E058 := E058 + 1;
      Interfaces.C'Elab_Spec;
      E043 := E043 + 1;
      System.Exceptions'Elab_Spec;
      E023 := E023 + 1;
      System.Object_Reader'Elab_Spec;
      E082 := E082 + 1;
      System.Dwarf_Lines'Elab_Spec;
      E048 := E048 + 1;
      System.Os_Lib'Elab_Body;
      E071 := E071 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E018 := E018 + 1;
      E011 := E011 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E037 := E037 + 1;
      E006 := E006 + 1;
      Ada.Assertions'Elab_Spec;
      E187 := E187 + 1;
      Ada.Strings.Utf_Encoding'Elab_Spec;
      E131 := E131 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E139 := E139 + 1;
      Ada.Strings.Text_Buffers'Elab_Spec;
      E129 := E129 + 1;
      Gnat'Elab_Spec;
      E199 := E199 + 1;
      Interfaces.C.Strings'Elab_Spec;
      E218 := E218 + 1;
      Ada.Streams'Elab_Spec;
      E152 := E152 + 1;
      System.File_Control_Block'Elab_Spec;
      E167 := E167 + 1;
      System.Finalization_Root'Elab_Spec;
      E158 := E158 + 1;
      Ada.Finalization'Elab_Spec;
      E150 := E150 + 1;
      System.File_Io'Elab_Body;
      E166 := E166 + 1;
      System.Storage_Pools'Elab_Spec;
      E160 := E160 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E149 := E149 + 1;
      Ada.Strings.Text_Buffers.Unbounded'Elab_Spec;
      E145 := E145 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E196 := E196 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E230 := E230 + 1;
      System.Task_Info'Elab_Spec;
      E118 := E118 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E206 := E206 + 1;
      Ada.Calendar.Delays'Elab_Body;
      E210 := E210 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E162 := E162 + 1;
      System.Task_Primitives.Operations'Elab_Body;
      E110 := E110 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E101 := E101 + 1;
      System.Pool_Global'Elab_Spec;
      E224 := E224 + 1;
      Gnat.Sockets'Elab_Spec;
      Gnat.Sockets.Thin_Common'Elab_Spec;
      E216 := E216 + 1;
      E208 := E208 + 1;
      Gnat.Sockets'Elab_Body;
      E201 := E201 + 1;
      E204 := E204 + 1;
      System.Tasking.Initialization'Elab_Body;
      E245 := E245 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E235 := E235 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E241 := E241 + 1;
      System.Tasking.Queuing'Elab_Body;
      E253 := E253 + 1;
      System.Tasking.Stages'Elab_Body;
      E259 := E259 + 1;
      Extensible_Http'Elab_Spec;
      Extensible_Http'Elab_Body;
      E169 := E169 + 1;
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
   --   /home/miko/basic_http_server/obj/validation/basic_http_server.o
   --   -L/home/miko/basic_http_server/obj/validation/
   --   -L/home/miko/basic_http_server/obj/validation/
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
