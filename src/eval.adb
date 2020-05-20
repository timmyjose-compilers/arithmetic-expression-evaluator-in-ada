with Ada.Text_IO;

package body Eval is
   procedure Show (E : in Expr) is
   begin
      case E.Kind is
         when Add =>
            Ada.Text_IO.Put ("Add(");
         when Sub =>
            Ada.Text_IO.Put ("Sub(");
         when Mul =>
            Ada.Text_IO.Put ("Mul(");
         when Div =>
            Ada.Text_IO.Put ("Div(");
         when Val =>
            Ada.Text_IO.Put (Image (E.Val));
            return;
      end case;

      Show (E.Left.all);
      Ada.Text_IO.Put (", ");
      Show (E.Right.all);
      Ada.Text_IO.Put (")");
   end Show;

   function Eval (E : in Expr) return T is
   begin
      case E.Kind is
         when Val =>
            return E.Val;
         when Add =>
            return Eval (E.Left.all) + Eval (E.Right.all);
         when Sub =>
            return Eval (E.Left.all) - Eval (E.Right.all);
         when Mul =>
            return Eval (E.Left.all) * Eval (E.Right.all);
         when Div =>
            return Eval (E.Left.all) / Eval (E.Right.all);
      end case;
   end Eval;
end Eval;
