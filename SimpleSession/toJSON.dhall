let Prelude = ../Prelude

let Map/Type = Prelude.Map.Type

let JSON = Prelude.JSON

let JSON/Type = JSON.Type

let JSON/null = JSON.null

let JSON/object = JSON.object

let JSON/string = JSON.string

let SimpleSession = ./Type

let toJSON
    : SimpleSession -> JSON/Type
    = \(input : SimpleSession) ->
        input
          JSON/Type
          { send =
              \(dataType : Type) ->
              \(inner : JSON/Type) ->
                JSON/object
                  ( toMap
                      { operation = JSON/string "send"
                      , dataType = JSON/string "TODO"
                      , andThen = inner
                      }
                  )
          , receive =
              \(dataType : Type) ->
              \(inner : JSON/Type) ->
                JSON/object
                  ( toMap
                      { operation = JSON/string "receive"
                      , dataType = JSON/string "TODO"
                      , andThen = inner
                      }
                  )
          , choose =
              \(branches : Map/Type Text JSON/Type) ->
                JSON/object
                  ( toMap
                      { operation = JSON/string "choose"
                      , branches = JSON/object branches
                      }
                  )
          , handle =
              \(branches : Map/Type Text JSON/Type) ->
                JSON/object
                  ( toMap
                      { operation = JSON/string "handle"
                      , branches = JSON/object branches
                      }
                  )
          , end = JSON/object (toMap { operation = JSON/string "end" })
          }

let check_end =
        assert
      : toJSON ./end === JSON/object (toMap { operation = JSON/string "end" })

let check_send =
        assert
      :     toJSON (./send Text ./end)
        ===  JSON/object
               ( toMap
                   { operation = JSON/string "send"
                   , dataType = JSON/string "TODO"
                   , andThen = JSON/object (toMap { operation = JSON/string "end" })
                   }
               )

let check_receive =
        assert
      :     toJSON (./receive Text ./end)
        ===  JSON/object
               ( toMap
                   { operation = JSON/string "receive"
                   , dataType = JSON/string "TODO"
                   , andThen = JSON/object (toMap { operation = JSON/string "end" })
                   }
               )

let check_choose =
        assert
      :     toJSON (./choose (toMap { x = ./end }))
        ===  JSON/object
               ( toMap
                   { operation = JSON/string "choose"
                   , branches =
                       JSON/object
                         ( toMap
                             { x =
                                 JSON/object
                                   (toMap { operation = JSON/string "end" })
                             }
                         )
                   }
               )

let check_handle =
        assert
      :     toJSON (./handle (toMap { x = ./end }))
        ===  JSON/object
               ( toMap
                   { operation = JSON/string "handle"
                   , branches =
                       JSON/object
                         ( toMap
                             { x =
                                 JSON/object
                                   (toMap { operation = JSON/string "end" })
                             }
                         )
                   }
               )

in  toJSON
