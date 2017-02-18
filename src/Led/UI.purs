module Led.UI
  ( State
  , Action
  , update
  , view
  ) where

import Led.AST (Expr(..))
import Prelude
import Pux (fromSimple)
import Pux.Html (Html)
import Pux.Html as H
import Pux.Html.Attributes as A

type State = Expr

type Action = Void

update = fromSimple absurd

view :: State -> Html Action
view (Var x) =
  H.span [A.className "led--expr -var"]
    [ H.text x
    ]
view (Abs x e) =
  H.span [A.className "led--expr -abs"]
    [ H.span [A.className "-parameter"] [H.text x]
    , view e
    ]
view (App e1 e2) =
  H.span [A.className "led--expr -app"]
    [ view e1
    , view e2
    ]
view (If branches default) =
  H.table [A.className "led--expr -if"] $
    join [ map viewBranch branches
         , [ H.tr []
              [ H.td [] [view default]
              , H.td [] []
              ]
           ]
         ]
  where
  viewBranch {value, condition} =
    H.tr []
      [ H.td [] [view value]
      , H.td [] [view condition]
      ]
