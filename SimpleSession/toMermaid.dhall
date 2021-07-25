let Map/Type = (../Prelude).Map.Type

let List/map = (../Prelude).List.map

let Mermaid/SD = (../MermaidJS).SequenceDiagram

let SimpleSession = ./Type

let left = "User"

let right = "ATM"

let toMermaid
    : SimpleSession -> Mermaid/SD.Type
    = \(input : SimpleSession) ->
      \(SequenceDiagram : Type) ->
      \ ( sequenceDiagram
        : { alt :
              List { body : SequenceDiagram, label : Text } -> SequenceDiagram
          , loop : { body : SequenceDiagram, label : Text } -> SequenceDiagram
          , opt : { body : SequenceDiagram, label : Text } -> SequenceDiagram
          , par :
              List { body : SequenceDiagram, label : Text } -> SequenceDiagram
          , sequence : List SequenceDiagram -> SequenceDiagram
          , statement :
              < Activation : { for : Text, status : < Activate | Deactivate > }
              | Message :
                  { arrow :
                      { arrowhead : < Cross | Filled | None | Unfilled >
                      , line : < Dotted | Solid >
                      }
                  , from : Text
                  , memo : Text
                  , to : Text
                  }
              | Note :
                  { content : Text
                  , position : < LeftOf | Over | RightOf >
                  , relativeTo : { first : Text, second : Optional Text }
                  }
              > ->
                SequenceDiagram
          }
        ) ->
        input
          SequenceDiagram
          { send =
              \(dataType : Type) ->
              \(s : SequenceDiagram) ->
                sequenceDiagram.sequence
                  [ sequenceDiagram.statement
                      ( Mermaid/SD.Statement.Message
                          { from = left
                          , to = right
                          , arrow =
                            { line = < Dotted | Solid >.Dotted
                            , arrowhead =
                                < Cross | Filled | None | Unfilled >.Filled
                            }
                          , memo = "TODO: type"
                          }
                      )
                  , s
                  ]
          , receive =
              \(dataType : Type) ->
              \(s : SequenceDiagram) ->
                sequenceDiagram.sequence
                  [ sequenceDiagram.statement
                      ( Mermaid/SD.Statement.Message
                          { from = right
                          , to = left
                          , arrow =
                            { line = < Dotted | Solid >.Dotted
                            , arrowhead =
                                < Cross | Filled | None | Unfilled >.Filled
                            }
                          , memo = "TODO: type"
                          }
                      )
                  , s
                  ]
          , choose =
              \(branches : Map/Type Text SequenceDiagram) ->
                sequenceDiagram.alt
                  ( List/map
                      { mapKey : Text, mapValue : SequenceDiagram }
                      { label : Text, body : SequenceDiagram }
                      ( \(x : { mapKey : Text, mapValue : SequenceDiagram }) ->
                          { label = ""
                          , body =
                              sequenceDiagram.sequence
                                [ sequenceDiagram.statement
                                    ( Mermaid/SD.Statement.Message
                                        { from = left
                                        , to = right
                                        , arrow =
                                          { line = < Dotted | Solid >.Solid
                                          , arrowhead =
                                              < Cross
                                              | Filled
                                              | None
                                              | Unfilled
                                              >.Filled
                                          }
                                        , memo = x.mapKey
                                        }
                                    )
                                , x.mapValue
                                ]
                          }
                      )
                      branches
                  )
          , handle =
              \(branches : Map/Type Text SequenceDiagram) ->
                sequenceDiagram.alt
                  ( List/map
                      { mapKey : Text, mapValue : SequenceDiagram }
                      { label : Text, body : SequenceDiagram }
                      ( \(x : { mapKey : Text, mapValue : SequenceDiagram }) ->
                          { label = ""
                          , body =
                              sequenceDiagram.sequence
                                [ sequenceDiagram.statement
                                    ( Mermaid/SD.Statement.Message
                                        { from = right
                                        , to = left
                                        , arrow =
                                          { line = < Dotted | Solid >.Solid
                                          , arrowhead =
                                              < Cross
                                              | Filled
                                              | None
                                              | Unfilled
                                              >.Filled
                                          }
                                        , memo = x.mapKey
                                        }
                                    )
                                , x.mapValue
                                ]
                          }
                      )
                      branches
                  )
          , end = sequenceDiagram.sequence ([] : List SequenceDiagram)
          }

in  toMermaid
