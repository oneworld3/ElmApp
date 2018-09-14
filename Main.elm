
--This is used to render the file to html
import Browser exposing (..)

--Importing all the html components to use such as div, p, button, etc
import Html exposing (..)

--Importing Attributes in Html tags that we need such as type, placeholder, etc
import Html.Attributes exposing (..)

--Importing events attributes such as onClick, onInput, etc
import Html.Events exposing (..)

--Importing String functions that is required to convert and handle any string operations
import String exposing (..)

main =
    --The sandbox is now used insteacd of beginnerProgram in elm version 0.19
    -- This gave me quite a hassle
    Browser.sandbox
        { init = initModel
        , update = update
        , view = view
        }

-- model part of the application

--We are creating a model with 4 variables
--We have used alias type for Model
type alias Model =
    { firstVariable : Float
    , secondVariable : Float
    , result : Float
    , error : Maybe String
    }

--Declaring the initial State of the Model
initModel : Model

--Simply assigning the value as 0
initModel =
    { firstVariable = 0
    , secondVariable = 0
    , result = 0
    , error = Nothing
    }



-- update part of the application

-- This is where I defined the typical functions that we will be using
-- when buttons are clicked or input fields are written
type Msg
    = Add
    | InputOne String
    | InputTwo String
    | Subtract
    | Multiply
    | Divide
    | Clear

-- We are creating an update function which takes two parameters and returns the model that we declared
update : Msg -> Model -> Model
update msg model =
    case msg of
        --Function to add
        Add ->
            { model
                | result = model.firstVariable + model.secondVariable
                , firstVariable = 0
                , secondVariable = 0
            }
        --Function to subtract
        Subtract ->
            { model
                | result = model.firstVariable - model.secondVariable
                , firstVariable = 0
                , secondVariable = 0
            }
        --Function to Multiply
        Multiply ->
            { model
                | result = model.firstVariable * model.secondVariable
                , firstVariable = 0
                , secondVariable = 0
            }
        --Function to Divide
        Divide ->
            { model
                | result = model.firstVariable / model.secondVariable
                , firstVariable = 0
                , secondVariable = 0
            }
        --Function to take the input
        InputOne val ->
            -- We need to convert the input to Float and we need to use Ok
            -- Because it returns a Mayb Float type and is different from Float
            -- Ok extracts the Float from a Mayb Float
            case Ok (String.toFloat val) of
                Ok input ->
                    { model
                        -- Maybe.withDefault is used to prevent error
                        | firstVariable = Maybe.withDefault 0 input
                        , error = Nothing
                    }
                -- if we get some kind of error, we store in the error
                -- and restore the first Variable vaalue to 0
                Err err ->
                    { model
                        | firstVariable = 0
                        , error = Just err
                    }

        --Function to take second Input    
        InputTwo val ->
            
            --Same as InputOne
            case Ok (String.toFloat val) of
                Ok input ->
                    { model
                        | secondVariable = Maybe.withDefault 0 input
                        , error = Nothing
                    }

                Err err ->
                    { model
                        | secondVariable = 0
                        , error = Just err
                    }

        --Function to Restore the model to the default State
        Clear ->
            initModel



-- view part of the application

-- initializing the model with 1 params and returning the Html Msg
-- This is basically all the html that we will be using to style our view part of the application
view : Model -> Html Msg

-- The following code is similar to:
-- <div>
--     <h3> Result : {a function to calculate thee value} </h3>
--     <input type = "text" onInput = "InputOne" placeholder = "firstVariable"/>
--     <input type = "text" onInput = "InputOne" placeholder = "firstVariable"/>
--     <button onClick = "Add"> Add </button>
--     <button onClick = "Subtract"> Add </button>
--     <button onClick = "Multiply"> Add </button>
--     <button onClick = "Divide"> Add </button>
--     <button onClick = "Clear"> Add </button>
-- </div> 
view model =
    div []
        [ h3 [] [ text ("Result: " ++ (Debug.toString model.result)) ]
        , input
            [ type_ "text"
            , onInput InputOne
            , value
                (if model.firstVariable == 0 then
                    ""
                 else
                    Debug.toString model.firstVariable
                )
            , placeholder "first Variable"
            ]
            []

        , input
            [ type_ "text"
            , onInput InputTwo
            , value
                (if model.secondVariable == 0 then
                    ""
                 else
                    Debug.toString model.secondVariable
                )
            , placeholder "Second Variable"
            ]
            []

        , div [] [ text (Maybe.withDefault "" model.error) ]
        , button
            [ type_ "button"
            , onClick Add
            ]
            [ text "Add" ]
        , button
            [ type_ "button"
            , onClick Subtract
            ]
            [ text "Subtract" ]
        , button
            [ type_ "button"
            , onClick Multiply
            ]
            [ text "Multiply" ]
        , button
            [ type_ "button"
            , onClick Divide
            ]
            [ text "Divide" ]
        , button
            [ type_ "button"
            , onClick Clear
            ]
            [ text "Clear" ]
        ]
