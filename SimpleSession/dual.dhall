let Map/Type = (./../Prelude).Map.Type

let SimpleSession = ./Type

let dual
    : SimpleSession -> SimpleSession
    = \(input : SimpleSession) ->
      \(SimpleSession : Type) ->
      \ ( session
        : { send : Type -> SimpleSession -> SimpleSession
          , receive : Type -> SimpleSession -> SimpleSession
          , choose : Map/Type Text SimpleSession -> SimpleSession
          , handle : Map/Type Text SimpleSession -> SimpleSession
          , end : SimpleSession
          }
        ) ->
        input
          SimpleSession
          { send =
              \(dataType : Type) ->
              \(s : SimpleSession) ->
                session.receive dataType s
          , receive =
              \(dataType : Type) ->
              \(s : SimpleSession) ->
                session.send dataType s
          , choose =
              \(branches : Map/Type Text SimpleSession) -> session.handle branches
          , handle =
              \(branches : Map/Type Text SimpleSession) -> session.choose branches
          , end = session.end
          }

in  dual
