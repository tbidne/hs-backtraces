# hs-backtraces

- Build with ghc 9.10.
- Idea: Testing IPE stacktraces with the following combinations:
  - Exception in:
    1. Pure code
    2. IO
    3. External library
  - HasCallStack vs. No HasCallStack
  - Thin function call vs. "extra" logic

### Pure exception

```
λ. cabal run hs-backtraces -- pure
hs-backtraces: Cannot decode byte '\x9e': Data.Text.Encoding: Invalid UTF-8 stream
IPE backtrace:
    Lib. (:)



```

```
λ. cabal run hs-backtraces -- pure extra
In ioPureExExtra
hs-backtraces: Cannot decode byte '\x9e': Data.Text.Encoding: Invalid UTF-8 stream
IPE backtrace:
    Lib. (:)
    Lib.pureExExtra (src/Lib.hs:44:14-26)
    Lib. (:)



```

### IO exception

What...? readBadFileHcs isn't involved at all...
```sh
λ. cabal run hs-backtraces -- io
hs-backtraces: bang: openFile: does not exist (No such file or directory)
IPE backtrace:
    Lib.readBadFile (src/Lib.hs:52:1-29)
    Lib.readBadFileHcs (src/Lib.hs:68:27-32)



```

```sh
λ. cabal run hs-backtraces -- io extra
In ioExExtra
hs-backtraces: bang: openFile: does not exist (No such file or directory)
IPE backtrace:
    Lib. (:)
    Lib.readBadFile (src/Lib.hs:52:24-29)



```

### IO + HasCallStack

```sh
λ. cabal run hs-backtraces -- hcs
hs-backtraces: bang: openFile: does not exist (No such file or directory)
IPE backtrace:
    Main.main (app/Main.hs:23:25-40)
    Lib.readBadFileHcs (src/Lib.hs:68:27-32)



```

```sh
λ. cabal run hs-backtraces -- hcs extra
In ioExExtraHcs
hs-backtraces: bang: openFile: does not exist (No such file or directory)
IPE backtrace:
    Main.main (app/Main.hs:23:25-40)
    Lib.readBadFileHcs (src/Lib.hs:68:27-32)



```

### Dependency exception

```sh
λ. cabal run hs-backtraces -- dep
hs-backtraces: bang: openFile: does not exist (No such file or directory)
IPE backtrace:
    Main.depEx (src/Lib.hs:87:1-28)
    Lib.readBadFileText (src/Lib.hs:84:45-50)



```

```sh
λ. cabal run hs-backtraces -- dep extra
In depExExtra
hs-backtraces: bang: openFile: does not exist (No such file or directory)
IPE backtrace:
    Lib. (:)
    Lib.depExExtra (src/Lib.hs:92:8-22)
    Lib.readBadFileText (src/Lib.hs:84:45-50)



```

### Dependency + HCS

```sh
λ. cabal run hs-backtraces -- dep hcs
hs-backtraces: bang: openFile: does not exist (No such file or directory)
IPE backtrace:
    Main.readBadFileTextHcs (src/Lib.hs:100:48-53)



```

```sh
λ. cabal run hs-backtraces -- dep extra hcs
In depExExtraHcs
hs-backtraces: bang: openFile: does not exist (No such file or directory)
IPE backtrace:
    Main.readBadFileTextHcs (src/Lib.hs:100:48-53)



```
