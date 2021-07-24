let Map/Type = (../Prelude).Map.Type

let Mermaid/SD = (../MermaidJS).SequenceDiagram

let SimpleSession = ./Type

let toMermaid
    : SimpleSession -> Mermaid/SD.Type
    = \(input : SimpleSession) ->
      \(SequenceDiagram : Type) ->
      \ ( sequenceDiagram
        : { alt :
              { body : SequenceDiagram, label : Text } ->
              { body : SequenceDiagram, label : Text } ->
                SequenceDiagram
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
        -- TODO: implement actual sequence diagram conversions
        input
          SequenceDiagram
          { send =
              \(dataType : Type) ->
              \(s : SequenceDiagram) ->
                sequenceDiagram.sequence ([] : List SequenceDiagram)
          , receive =
              \(dataType : Type) ->
              \(s : SequenceDiagram) ->
                sequenceDiagram.sequence ([] : List SequenceDiagram)
          , choose =
              \(branches : Map/Type Text SequenceDiagram) ->
                sequenceDiagram.sequence ([] : List SequenceDiagram)
          , handle =
              \(branches : Map/Type Text SequenceDiagram) ->
                sequenceDiagram.sequence ([] : List SequenceDiagram)
          , end = sequenceDiagram.sequence ([] : List SequenceDiagram)
          }

in  toMermaid
