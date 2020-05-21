with Eval;

package My_Custom_Int is
   type My_Custom_Int is record
      Int_Val : Integer range 1 .. 100;
   end record;

   function Image (E: in My_Custom_Int) return String;

   function "=" (L, R : in My_Custom_Int) return Boolean;
   function "+" (L, R : in My_Custom_Int) return My_Custom_Int;
   function "-" (L, R : in My_Custom_Int) return My_Custom_Int;
   function "*" (L, R : in My_Custom_Int) return My_Custom_Int;
   function "/" (L, R : in My_Custom_Int) return My_Custom_Int;
end My_Custom_Int;
