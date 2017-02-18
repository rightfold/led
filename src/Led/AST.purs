module Led.AST
  ( Expr(..)
  ) where

data Expr
  = Var String
  | Abs String Expr
  | App Expr Expr
  | If (Array {value :: Expr, condition :: Expr}) Expr
