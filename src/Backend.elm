module Backend exposing (Model, app)

import Bridge exposing (ToBackend(..))
import Lamdera exposing (ClientId, SessionId)
import Types exposing (BackendModel, BackendMsg(..), ToFrontend(..))


type alias Model =
    BackendModel


app :
    { init : ( Model, Cmd BackendMsg )
    , update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
    , updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
    , subscriptions : Model -> Sub BackendMsg
    }
app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = \_ -> Lamdera.onConnect OnConnect
        }


init : ( Model, Cmd BackendMsg )
init =
    ( { smashedLikes = 0 }, Cmd.none )


update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
update msg model =
    case msg of
        OnConnect _ cid ->
            ( model, Lamdera.sendToFrontend cid <| NewSmashedLikes model.smashedLikes )


updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
updateFromFrontend _ _ msg model =
    case msg of
        SmashedLikeButton ->
            let
                newSmashedLikes : Int
                newSmashedLikes =
                    model.smashedLikes + 1
            in
            ( { model | smashedLikes = newSmashedLikes }, Lamdera.broadcast <| NewSmashedLikes newSmashedLikes )
