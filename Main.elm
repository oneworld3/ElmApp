module Main exposing (main)

import Html


add a b =
    a + b


result =
    add 2 2 |> \a -> modBy 2 a == 0


main =
    Html.text (Debug.toString result)
