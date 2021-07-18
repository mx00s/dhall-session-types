let SimpleSession = ./Type

let send = ./send
let receive = ./receive
let choose = ./choose
let handle = ./handle
let end = ./end

let String = Text

let Real = Double

let example
    : SimpleSession
    = send
        String
        ( handle
            ( toMap
                { success =
                    choose
                      ( toMap
                          { deposit =
                              send
                                Real
                                (receive Real end)
                          , withdraw =
                              send
                                Real
                                ( handle
                                    ( toMap
                                        { dispense = end
                                        , overdraft = end
                                        }
                                    )
                                )
                          }
                      )
                , failure = end
                }
            )
        )

in  example
