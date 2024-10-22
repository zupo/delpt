module Pages.Home_ exposing (Model, Msg(..), page)

import Bridge
import Effect exposing (Effect)
import Html.Styled exposing (div, h1, img, p, text)
import Html.Styled.Attributes exposing (alt, css, src, style)
import Html.Styled.Events exposing (onClick)
import Lamdera
import Page exposing (Page)
import Route exposing (Route)
import Shared
import Tailwind.Utilities as Tw
import View exposing (View)


page : Shared.Model -> Route () -> Page Model Msg
page shared _ =
    Page.new
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view shared
        }



-- INIT


type alias Model =
    {}


init : () -> ( Model, Effect Msg )
init _ =
    ( {}
    , Effect.none
    )



-- UPDATE


type Msg
    = SmashedLikeButton


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        SmashedLikeButton ->
            ( model
            , Effect.sendCmd <| Lamdera.sendToBackend Bridge.SmashedLikeButton
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Shared.Model -> Model -> View Msg
view shared _ =
    { title = "Elm Land ❤️ Lamdera"
    , body =
        [ div
            [ css
                [ Tw.flex
                , Tw.gap_4
                ]
            ]
            [ img
                [ alt "Lando, the Elm Land Rainbow"
                , src "https://elm.land/images/logo-480.png"
                , css
                    [ Tw.w_32
                    , Tw.mr_10
                    ]
                ]
                []
            , img
                [ alt "Laurie, the Lamdera Lambda Llamba"
                , src "https://lamdera.com/images/llama/floaty.png"
                , css
                    [ Tw.w_20
                    , Tw.mr_6
                    , Tw.h_28
                    ]
                ]
                []
            ]
        , h1
            [ css
                [ Tw.text_3xl
                , Tw.font_bold
                ]
            ]
            [ text "Elm Land ❤️ Lamdera" ]
        , p
            [ css
                [ Tw.font_sans
                , Tw.opacity_75
                , Tw.my_5
                ]
            ]
            [ text "It's working, Mario!!" ]
        , p
            [ css
                [ Tw.font_sans
                , Tw.cursor_pointer
                , Tw.p_1
                , Tw.rounded_md
                , Tw.select_none
                ]
            , style "background-color" "#ffffff40"
            , onClick SmashedLikeButton
            ]
            [ text <| "👍 " ++ String.fromInt shared.smashedLikes ]
        ]
    }
