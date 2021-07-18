let Map = (./../Prelude).Map

let Map/Type = Map.Type

let Map/map = Map.map

let SimpleSession = ./Type

let choose
    : Map/Type Text SimpleSession -> SimpleSession
    = \(branches : Map/Type Text SimpleSession) ->
      \(SimpleSession : Type) ->
      \ ( session
        : { send : Type -> SimpleSession -> SimpleSession
          , receive : Type -> SimpleSession -> SimpleSession
          , choose : Map/Type Text SimpleSession -> SimpleSession
          , handle : Map/Type Text SimpleSession -> SimpleSession
          , end : SimpleSession
          }
        ) ->
        session.choose
          ( Map/map
              Text
              SimpleSession@1
              SimpleSession
              (\(s : SimpleSession@1) -> s SimpleSession session)
              branches
          )

in  choose
