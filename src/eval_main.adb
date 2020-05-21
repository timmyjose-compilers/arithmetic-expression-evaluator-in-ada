with Ada.Text_IO;
with Ada.Float_Text_IO;

with Eval;
with My_Custom_Int;

procedure Eval_Main is
   package Eval_Integer is new Eval (T => Integer, Image => Integer'Image,
      "=" => "=", "+" => "+", "-" => "-", "*" => "*", "/" => "/");

   package Eval_Float is new Eval (T => Float, Image => Float'Image,
      "=" => "=", "+" => "+", "-" => "-", "*" => "*", "/" => "/");

   -- works for custom types as well
   package Eval_My_Custom_Int is new Eval (T => My_Custom_Int.My_Custom_Int,
      Image => My_Custom_Int.Image, "=" => My_Custom_Int."=",
      "+" => My_Custom_Int."+", "-" => My_Custom_Int."-",
      "*" => My_Custom_Int."*", "/" => My_Custom_Int."/");

   -- 2 + 3 * 4
   E1 : constant Eval_Integer.Expr :=
     (Kind  => Eval_Integer.Add,
      Left  => new Eval_Integer.Expr'(Kind => Eval_Integer.Val, Val => 2),
      Right =>
        new Eval_Integer.Expr'
          (Kind  => Eval_Integer.Mul,
           Left  => new Eval_Integer.Expr'(Kind => Eval_Integer.Val, Val => 3),
           Right =>
             new Eval_Integer.Expr'(Kind => Eval_Integer.Val, Val => 4)));

   -- 10 / 2 - 3
   E2 : constant Eval_Integer.Expr :=
     (Kind => Eval_Integer.Sub,
      Left =>
        new Eval_Integer.Expr'
          (Kind  => Eval_Integer.Div,
           Left => new Eval_Integer.Expr'(Kind => Eval_Integer.Val, Val => 10),
           Right =>
             new Eval_Integer.Expr'(Kind => Eval_Integer.Val, Val => 2)),
      Right => new Eval_Integer.Expr'(Kind => Eval_Integer.Val, Val => 3));

   -- 2.3 * 4.5 + 1.2
   E3 : constant Eval_Float.Expr :=
     (Kind => Eval_Float.Add,
      Left =>
        new Eval_Float.Expr'
          (Kind  => Eval_Float.Mul,
           Left  => new Eval_Float.Expr'(Kind => Eval_Float.Val, Val => 2.3),
           Right => new Eval_Float.Expr'(Kind => Eval_Float.Val, Val => 4.5)),
      Right => new Eval_Float.Expr'(Kind => Eval_Float.Val, Val => 1.2));

   -- 1.0 / 0.0
   E4 : constant Eval_Float.Expr :=
     (Kind  => Eval_Float.Div,
      Left  => new Eval_Float.Expr'(Kind => Eval_Float.Val, Val => 1.0),
      Right => new Eval_Float.Expr'(Kind => Eval_Float.Val, Val => 0.0));

   -- My_Custom_Int { Int_Val : 10 } * My_Custom_Int { Int_Val : 2 } / My_Custom_Int { Int_Val : 5 }
   E5 : constant Eval_My_Custom_Int.Expr :=
     (Kind => Eval_My_Custom_Int.Div,
      Left =>
        new Eval_My_Custom_Int.Expr'
          (Kind => Eval_My_Custom_Int.Mul,
           Left =>
             new Eval_My_Custom_Int.Expr'
               (Kind => Eval_My_Custom_Int.Val, Val => (Int_Val => 10)),
           Right =>
             new Eval_My_Custom_Int.Expr'
               (Kind => Eval_My_Custom_Int.Val, Val => (Int_Val => 2))),
      Right =>
        new Eval_My_Custom_Int.Expr'
          (Kind => Eval_My_Custom_Int.Val, Val => (Int_Val => 5)));

   -- My_Custom_Int { Int_Val : 100 } * My_Custom_Int { Int_Val : 2 } / My_Custom_Int { Int_Val : 5 }
   E6 : constant Eval_My_Custom_Int.Expr :=
     (Kind => Eval_My_Custom_Int.Div,
      Left =>
        new Eval_My_Custom_Int.Expr'
          (Kind => Eval_My_Custom_Int.Mul,
           Left =>
             new Eval_My_Custom_Int.Expr'
               (Kind => Eval_My_Custom_Int.Val, Val => (Int_Val => 100)),
           Right =>
             new Eval_My_Custom_Int.Expr'
               (Kind => Eval_My_Custom_Int.Val, Val => (Int_Val => 2))),
      Right =>
        new Eval_My_Custom_Int.Expr'
          (Kind => Eval_My_Custom_Int.Val, Val => (Int_Val => 5)));

begin
   Ada.Text_IO.Put ("The expression E1 is : ");
   Eval_Integer.Show (E1);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put
     ("And its value is " & Integer'Image (Eval_Integer.Eval (E1)));
   Ada.Text_IO.New_Line (2);

   Ada.Text_IO.Put ("The expression E2 is : ");
   Eval_Integer.Show (E2);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put
     ("And its value is " & Integer'Image (Eval_Integer.Eval (E2)));
   Ada.Text_IO.New_Line (2);

   Ada.Text_IO.Put ("The expression E3 is : ");
   Eval_Float.Show (E3);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put ("And its value is ");
   Ada.Float_Text_IO.Put (Eval_Float.Eval (E3), Aft => 3, Exp => 0);
   Ada.Text_IO.New_Line (2);

   Ada.Text_IO.Put ("The expression E4 is : ");
   Eval_Float.Show (E4);
   Ada.Text_IO.Put ("And its value is : ");
   Ada.Float_Text_IO.Put (Eval_Float.Eval (E4), Aft => 3, Exp => 0);
   Ada.Text_IO.New_Line (2);

   Ada.Text_IO.Put ("The expression E5 is : ");
   Eval_My_Custom_Int.Show (E5);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put ("And its value is : ");
   Ada.Text_IO.Put (My_Custom_Int.Image (Eval_My_Custom_Int.Eval (E5)));
   Ada.Text_IO.New_Line (2);

   declare
   begin
      Ada.Text_IO.Put ("The expression E6 is : ");
      Eval_My_Custom_Int.Show (E6);
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put ("And its value is : ");
      Ada.Text_IO.Put (My_Custom_Int.Image (Eval_My_Custom_Int.Eval (E6)));
      Ada.Text_IO.New_Line (2);
   exception
      when Constraint_Error =>
         Ada.Text_IO.Put_Line
           (Ada.Text_IO.Standard_Error,
            "Range check failed - too big a value for the My_Custom_Int type");
   end;
end Eval_Main;
