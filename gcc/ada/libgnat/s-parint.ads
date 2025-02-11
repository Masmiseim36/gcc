------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--            S Y S T E M . P A R T I T I O N _ I N T E R F A C E           --
--                                                                          --
--                                  S p e c                                 --
--                                                                          --
--          Copyright (C) 1995-2025, Free Software Foundation, Inc.         --
--                                                                          --
-- GNARL is free software; you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

--  This unit may be used directly from an application program by providing
--  an appropriate WITH, and the interface can be expected to remain stable.

with Ada.Exceptions;
with Ada.Streams;
with Interfaces;
with System.RPC;

package System.Partition_Interface is
   pragma Elaborate_Body;

   type DSA_Implementation_Name is (No_DSA, GARLIC_DSA, PolyORB_DSA);
   DSA_Implementation : constant DSA_Implementation_Name := No_DSA;
   --  Identification of this DSA implementation variant

   PCS_Version : constant := 1;
   --  Version of the PCS API (for Exp_Dist consistency check)
   --
   --  This version number is matched against corresponding element of
   --  Exp_Dist.PCS_Version_Number to ensure that the versions of Exp_Dist
   --  and the PCS are consistent.

   --  RCI receiving stubs contain a table of descriptors for all user
   --  subprograms exported by the unit.

   type Subprogram_Id is new Natural;
   First_RCI_Subprogram_Id : constant := 2;

   type RCI_Subp_Info is record
      Addr : System.Address;
      --  Local address of the proxy object
   end record;

   type RCI_Subp_Info_Access is access all RCI_Subp_Info;
   type RCI_Subp_Info_Array is array (Integer range <>) of
     aliased RCI_Subp_Info;

   subtype Unit_Name is String;
   --  Name of Ada units

   type Main_Subprogram_Type is access procedure;

   type RACW_Stub_Type is tagged record
      Origin       : RPC.Partition_ID;
      Receiver     : Interfaces.Unsigned_64;
      Addr         : Interfaces.Unsigned_64;
      Asynchronous : Boolean;
   end record;

   type RACW_Stub_Type_Access is access RACW_Stub_Type;
   --  This type is used by the expansion to implement distributed objects.
   --  Do not change its definition or its layout without updating
   --  exp_dist.adb.

   type RAS_Proxy_Type is tagged limited record
      All_Calls_Remote : Boolean;
      Receiver         : System.Address;
      Subp_Id          : Subprogram_Id;
   end record;

   type RAS_Proxy_Type_Access is access RAS_Proxy_Type;
   pragma No_Strict_Aliasing (RAS_Proxy_Type_Access);
   --  This type is used by the expansion to implement distributed objects.
   --  Do not change its definition or its layout without updating
   --  Exp_Dist.Build_Remote_Subprogram_Proxy_Type.

   --  The Request_Access type is used for communication between the PCS
   --  and the RPC receiver generated by the compiler: it contains all the
   --  necessary information for the receiver to process an incoming call.

   type RST_Access is access all Ada.Streams.Root_Stream_Type'Class;
   type Request_Access is record
      Params : RST_Access;
      --  A stream describing the called subprogram and its parameters

      Result : RST_Access;
      --  A stream where the result, raised exception, or out values,
      --  are marshalled.
   end record;

   procedure Check
     (Name    : Unit_Name;
      Version : String;
      RCI     : Boolean := True);
   --  Use by the main subprogram to check that a remote receiver
   --  unit has the same version than the caller's one.

   function Same_Partition
      (Left  : not null access RACW_Stub_Type;
       Right : not null access RACW_Stub_Type) return Boolean;
   --  Determine whether Left and Right correspond to objects instantiated
   --  on the same partition, for enforcement of E.4(19).

   function Get_Active_Partition_ID (Name : Unit_Name) return RPC.Partition_ID;
   --  Similar in some respects to RCI_Locator.Get_Active_Partition_ID

   function Get_Active_Version (Name : Unit_Name) return String;
   --  Similar in some respects to Get_Active_Partition_ID

   function Get_Local_Partition_ID return RPC.Partition_ID;
   --  Return the Partition_ID of the current partition

   function Get_Passive_Partition_ID
     (Name : Unit_Name) return RPC.Partition_ID;
   --  Return the Partition_ID of the given shared passive partition

   function Get_Passive_Version (Name : Unit_Name) return String;
   --  Return the version corresponding to a shared passive unit

   function Get_RCI_Package_Receiver
     (Name : Unit_Name) return Interfaces.Unsigned_64;
   --  Similar in some respects to RCI_Locator.Get_RCI_Package_Receiver

   procedure Get_Unique_Remote_Pointer
     (Handler : in out RACW_Stub_Type_Access);
   --  Get a unique pointer on a remote object

   procedure Raise_Program_Error_Unknown_Tag
     (E : Ada.Exceptions.Exception_Occurrence);
   pragma No_Return (Raise_Program_Error_Unknown_Tag);
   --  Raise Program_Error with the same message as E one

   type RPC_Receiver is access procedure (R : Request_Access);
   procedure Register_Receiving_Stub
     (Name          : Unit_Name;
      Receiver      : RPC_Receiver;
      Version       : String := "";
      Subp_Info     : System.Address;
      Subp_Info_Len : Integer);
   --  Register the fact that the Name receiving stub is now elaborated.
   --  Register the access value to the package RPC_Receiver procedure.

   procedure Get_RAS_Info
     (Name          :  Unit_Name;
      Subp_Id       :  Subprogram_Id;
      Proxy_Address : out Interfaces.Unsigned_64);
   --  Look up the address of the proxy object for the given subprogram
   --  in the named unit, or Null_Address if not present on the local
   --  partition.

   procedure Register_Passive_Package
     (Name    : Unit_Name;
      Version : String := "");
   --  Register a passive package

   generic
      RCI_Name : String;
      Version  : String;
   package RCI_Locator is
      pragma Unreferenced (Version);

      function Get_RCI_Package_Receiver return Interfaces.Unsigned_64;
      function Get_Active_Partition_ID return RPC.Partition_ID;
   end RCI_Locator;
   --  RCI package information caching

   procedure Run (Main : Main_Subprogram_Type := null);
   --  Run the main subprogram

end System.Partition_Interface;
