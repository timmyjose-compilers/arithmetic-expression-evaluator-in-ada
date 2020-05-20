generic
   type T is private;
   with function Image (Item : T) return String;
   with function "=" (First_Item, Second_Item : T) return Boolean;
   with function "+" (First_Item, Second_Item : T) return T;
   with function "-" (First_Item, Second_Item : T) return T;
   with function "*" (First_Item, Second_Item : T) return T;
   with function "/" (First_Item, Second_Item : T) return T;
package Eval is
   type Expr;
   type Expr_Access is access Expr;

   type Expr_Type is (Add, Sub, Mul, Div, Val);

   type Expr (Kind : Expr_Type) is record
      case Kind is
         when Val =>
            Val : T;
         when others =>
            Left, Right : Expr_Access;
      end case;
   end record;

   procedure Show (E : in Expr);
   function Eval (E : in Expr) return T;
end Eval;
