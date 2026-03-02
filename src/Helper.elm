module Helper exposing
    ( AirplaneStatus(..)
    , GradeStatus(..)
    , airplaneScheduleAction
    , airportAction
    , categoricalGrade
    , main
    )

import Browser
import Html exposing (Html, li, text, ul)


type GradeStatus
    = Approved
    | Failed
    | Pending


categoricalGrade : List Float -> List GradeStatus
categoricalGrade grades =
    List.map gradeToStatus grades


gradeToStatus : Float -> GradeStatus
gradeToStatus grade =
    if grade < 0 then
        Pending

    else if grade > 7 then
        Approved

    else
        Failed


type AirplaneStatus
    = OnTime
    | Boarding
    | Delayed
    | Cancelled


airplaneScheduleAction : AirplaneStatus -> String
airplaneScheduleAction status =
    case status of
        Cancelled ->
            "Pedir reembolso"

        Delayed ->
            "Esperar"

        OnTime ->
            "Esperar"

        Boarding ->
            "Buscar boleto"


airportAction : List AirplaneStatus -> List String
airportAction statuses =
    List.map airplaneScheduleAction statuses


type alias Model =
    { grades : List Float
    , flights : List AirplaneStatus
    }


init : Model
init =
    { grades = [ 10, 7, 6.9, -1, 8.5 ]
    , flights = [ Cancelled, Delayed, OnTime, Boarding ]
    }


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html Msg
view model =
    ul []
        (List.map liText
            (airportAction model.flights)
        )


liText : String -> Html Msg
liText s =
    li [] [ text s ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
