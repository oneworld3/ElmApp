import Browser

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main =
  Browser.sandbox { init = initModel, update = update, view = view }

--Model

type alias Model =
    Int

initModel : Model

initModel =
    0

--Update

type Msg = 
    AddCalcorie
    | Clear

update: Msg -> Model -> Model
update msg model =
    case msg of
        AddCalcorie ->
            model + 1

        Clear ->
            initModel

--View //Create View in Html

view: Model -> Html Msg
view model =
    div []
        [
            h3  [][text ("Counter: " ++ (Debug.toString model)) ]

            ,button [type_ "button", onClick AddCalcorie][text "Add"]
            ,button [type_ "button", onClick Clear][text "Clear"]
        ]
