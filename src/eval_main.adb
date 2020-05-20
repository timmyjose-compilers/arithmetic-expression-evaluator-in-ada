with Ada.Text_IO;
with Ada.Float_Text_IO;

with Eval;

procedure Eval_Main is
   package Eval_Integer is new Eval (T => Integer, Image => Integer'Image,
      "=" => "=", "+" => "+", "-" => "-", "*" => "*", "/" => "/");

   package Eval_Float is new Eval (T => Float, Image => Float'Image,
      "=" => "=", "+" => "+", "-" => "-", "*" => "*", "/" => "/");

   -- 2 + 3 * 4
   E1 : Eval_Integer.Expr :=
     (Kind  => Eval_Integer.Add,
      Left  => new Eval_Integer.Expr'(Kind => Eval_Integer.Val, Val => 2),
      Right =>
        new Eval_Integer.Expr'
          (Kind  => Eval_Integer.Mul,
           Left  => new Eval_Integer.Expr'(Kind => Eval_Integer.Val, Val => 3),
           Right =>
             new Eval_Integer.Expr'(Kind => Eval_Integer.Val, Val => 4)));

   -- 10 / 2 - 3
   E2 : Eval_Integer.Expr :=
     (Kind => Eval_Integer.Sub,
      Left =>
        new Eval_Integer.Expr'
          (Kind  => Eval_Integer.Div,
           Left => new Eval_Integer.Expr'(Kind => Eval_Integer.Val, Val => 10),
           Right =>
             new Eval_Integer.Expr'(Kind => Eval_Integer.Val, Val => 2)),
      Right => new Eval_Integer.Expr'(Kind => Eval_Integer.Val, Val => 3));

   -- 2.3 * 4.5 + 1.2
   E3 : Eval_Float.Expr :=
     (Kind => Eval_Float.Add,
      Left =>
        new Eval_Float.Expr'
          (Kind  => Eval_Float.Mul,
           Left  => new Eval_Float.Expr'(Kind => Eval_Float.Val, Val => 2.3),
           Right => new Eval_Float.Expr'(Kind => Eval_Float.Val, Val => 4.5)),
      Right => new Eval_Float.Expr'(Kind => Eval_Float.Val, Val => 1.2));
begin
   Ada.Text_IO.Put ("The expression E1 is : ");
   Eval_Integer.Show (E1);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put
     ("And its value is " & Integer'Image (Eval_Integer.Eval (E1)));
   Ada.Text_IO.New_Line;

   Ada.Text_IO.Put ("The expression E2 is : ");
   Eval_Integer.Show (E2);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put
     ("And its value is " & Integer'Image (Eval_Integer.Eval (E2)));

   Ada.Text_IO.Put ("The expression E3 is : ");
   Eval_Float.Show (E3);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put ("And its value is ");
   Ada.Float_Text_IO.Put (Eval_Float.Eval (E3), Aft => 3, Exp => 0);
end Eval_Main;
