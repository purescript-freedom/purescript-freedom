{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "basic"
, dependencies =
    [ "freedom"
    , "freedom-portal"
    , "freedom-router"
    , "milkis"
    , "record"
    , "simple-json"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs" ]
}
