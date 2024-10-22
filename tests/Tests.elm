module Tests exposing (suite)

import Expect exposing (equal)
import Test exposing (Test, test)


suite : Test
suite =
    test "example" <|
        \_ -> equal 1 1
