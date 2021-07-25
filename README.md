# dhall-session-types

This is an experiment to implement an encoding of session types in Dhall. My main source for the theory is currently [Sessions and Session Types: an Overview](http://www.di.unito.it/~dezani/papers/sto.pdf).

For now only a minimal session type language is supported, but the hope is to explore more sophisticated extensions and opportunities to generate useful artifacts and code from these types.

All interfaces here are unstable and unversioned until further notice. If want to use these types anyway, consider pinning to a specific git revision on the `main` branch.

## Simple Session

`./SimpleSession` corresponds to the minimal session types language described on page 5 which includes operators for send (`!`), receive (`?`), choose (`⊕`), handle (`&`), and of course the trivial session type, `end`.

The User-ATM interaction example session type is implemented in `./SimpleSession/user-atm.dhall`.

```bash
dhall <<< './SimpleSession/user-atm.dhall'
```

And the dual session type for the same interaction from the ATM's perspective is implemented using the `./SimpleSession/dual` function.

```bash
cat ./SimpleSession/atm-user.dhall
dhall <<< './SimpleSession/atm-user.dhall'
```

There's also a `./SimpleSession/toJSON` function to convert `SimpleSession`s into Dhall's standard JSON type, which in turn can be rendered. (WARNING: As of this writing `toJSON` does not convey any information about the data types associated with `send` and `receive` operations.)

```bash
dhall text <<< '(./Prelude).JSON.render (./SimpleSession/toJSON ./SimpleSession/user-atm.dhall)'
```

Simple sessions can also be converted to a Dhall representation of [mermaid-js' sequence diagrams](https://mermaid-js.github.io/mermaid/#/sequenceDiagram).

```bash
dhall text <<< '(./MermaidJS).SequenceDiagram.render (./SimpleSession/toMermaid ./SimpleSession/user-atm.dhall)'
```
