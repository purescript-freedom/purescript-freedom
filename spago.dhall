{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "freedom"
, dependencies =
    [ "web-html", "simple-emitter", "console", "safely", "foreign-object" ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs" ]
}
