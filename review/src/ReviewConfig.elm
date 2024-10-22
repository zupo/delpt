module ReviewConfig exposing (config)

{-| Do not rename the ReviewConfig module or the config function, because
`elm-review` will look for these.

To add packages that contain rules, add them to this review project using

    `elm install author/packagename`

when inside the directory containing this file.

-}

import Docs.ReviewAtDocs
import NoConfusingPrefixOperator
import NoDebug.Log
import NoDebug.TodoOrToString
import NoExposingEverything
import NoImportingEverything
import NoMissingTypeAnnotation
import NoMissingTypeAnnotationInLetIn
import NoMissingTypeExpose
import NoPrematureLetComputation
import NoSimpleLetBody
import NoUnused.Dependencies
import NoUnused.Exports
import NoUnused.Parameters
import NoUnused.Patterns
import NoUnused.Variables
import Review.Rule as Rule exposing (Rule)
import Simplify


config : List Rule
config =
    [ Docs.ReviewAtDocs.rule
    , NoConfusingPrefixOperator.rule
        |> Rule.ignoreErrorsForDirectories [ ".elm-land/", "src/Evergreen/" ]
    , NoDebug.Log.rule
        |> Rule.ignoreErrorsForDirectories [ ".elm-land/", "src/Evergreen/" ]
    , NoDebug.TodoOrToString.rule
        |> Rule.ignoreErrorsForDirectories [ "tests/" ]
    , NoExposingEverything.rule
        |> Rule.ignoreErrorsForDirectories [ ".elm-land/", "src/Evergreen/" ]
    , NoImportingEverything.rule []
        |> Rule.ignoreErrorsForDirectories [ ".elm-land/", "src/Evergreen/" ]
    , NoMissingTypeAnnotation.rule
        |> Rule.ignoreErrorsForDirectories [ ".elm-land/", "src/Evergreen/" ]
    , NoMissingTypeAnnotationInLetIn.rule
        |> Rule.ignoreErrorsForDirectories [ ".elm-land/", "src/Evergreen/" ]
    , NoMissingTypeExpose.rule
        |> Rule.ignoreErrorsForDirectories [ ".elm-land/", "src/Evergreen/" ]
    , NoSimpleLetBody.rule
        |> Rule.ignoreErrorsForDirectories [ ".elm-land/", "src/Evergreen/" ]
    , NoPrematureLetComputation.rule
        |> Rule.ignoreErrorsForDirectories [ ".elm-land/", "src/Evergreen/" ]
    , NoUnused.Exports.rule
        |> Rule.ignoreErrorsForDirectories [ ".elm-land/", "src/Evergreen/" ]
    , NoUnused.Parameters.rule
        |> Rule.ignoreErrorsForDirectories [ ".elm-land/", "src/Evergreen/" ]
    , NoUnused.Patterns.rule
        |> Rule.ignoreErrorsForDirectories [ ".elm-land/", "src/Evergreen/" ]
    , NoUnused.Variables.rule
        |> Rule.ignoreErrorsForDirectories [ ".elm-land/", "src/Evergreen/" ]
    , Simplify.rule Simplify.defaults
        |> Rule.ignoreErrorsForDirectories [ ".elm-land/", "src/Evergreen/" ]
    ]
