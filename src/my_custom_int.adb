package body My_Custom_Int is
   function Image (E : in My_Custom_Int) return String is
   begin
      return "My_Custom_Int { Int_Val = " & Integer'Image (E.Int_Val) & " }";
   end Image;

   function "=" (L, R : in My_Custom_Int) return Boolean is
   begin
      return L.Int_Val = R.Int_Val;
   end "=";

   function "+" (L, R : in My_Custom_Int) return My_Custom_Int is
      Temp : My_Custom_Int;
   begin
      Temp.Int_Val := L.Int_Val + R.Int_Val;
      return Temp;
   end "+";

   function "-" (L, R : in My_Custom_Int) return My_Custom_Int is
      Temp : My_Custom_Int;
   begin
      Temp.Int_Val := L.Int_Val - R.Int_Val;
      return Temp;
   end "-";

   function "*" (L, R : in My_Custom_Int) return My_Custom_Int is
      Temp : My_Custom_Int;
   begin
      Temp.Int_Val := L.Int_Val * R.Int_Val;
      return Temp;
   end "*";

   function "/" (L, R : in My_Custom_Int) return My_Custom_Int is
      Temp : My_Custom_Int;
   begin
      Temp.Int_Val := L.Int_Val / R.Int_Val;
      return Temp;
   end "/";
end My_Custom_Int;
