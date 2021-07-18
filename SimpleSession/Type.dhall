let Map/Type = (./../Prelude).Map.Type

let SimpleSession/Type
    : Type
    = forall (SimpleSession : Type) ->
      forall  ( session
              : { send : Type -> SimpleSession -> SimpleSession
                , receive : Type -> SimpleSession -> SimpleSession
                , choose : Map/Type Text SimpleSession -> SimpleSession
                , handle : Map/Type Text SimpleSession -> SimpleSession
                , end : SimpleSession
                }
              ) ->
        SimpleSession

in  SimpleSession/Type
