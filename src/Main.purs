module Main
  ( main
  ) where

import Led.AST (Expr(..))
import Led.UI as UI
import Prelude
import Pux (renderToDOM, start)

main = do
  app <- start
    { initialState: f
    , update: UI.update
    , view: UI.view
    , inputs: []
    }
  renderToDOM "#app" app.html

  where
  f = Abs "f" (Abs "x" (Abs "y" (Abs "z" (App (Var "z") e))))
  e = If [ {value: App (Var "f") (App (Var "x") (Var "y")), condition: Var "x"}
         , {value: App (Var "f") (App (Var "f") (App (Var "x") (Var "y"))), condition: Var "y"}
         ] (App (Var "f") (Abs "a" (Var "z")))
