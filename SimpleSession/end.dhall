let Map/Type = (./../Prelude).Map.Type

let SimpleSession = ./Type

let end
    : SimpleSession
    = \(SimpleSession : Type) ->
      \ ( session
        : { send : Type -> SimpleSession -> SimpleSession
          , receive : Type -> SimpleSession -> SimpleSession
          , choose : Map/Type Text SimpleSession -> SimpleSession
          , handle : Map/Type Text SimpleSession -> SimpleSession
          , end : SimpleSession
          }
        ) ->
        session.end

in  end
