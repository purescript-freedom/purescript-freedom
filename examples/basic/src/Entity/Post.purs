module Entity.Post where

type Post =
  { id :: Int
  , userId :: Int
  , title :: String
  , body :: String
  }

updateTitle :: forall r. String -> { title :: String | r } -> { title :: String | r }
updateTitle title = _ { title = title }

updateBody :: forall r. String -> { body :: String | r } -> { body :: String | r }
updateBody body = _ { body = body }
