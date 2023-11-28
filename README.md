# module-deprecate

Module deprecations appear to apply to every export, not just the module name.

## Bad Example

```haskell
-- Deprecated.hs
module Deprecated {-# deprecated "This entire module is deprecated" #-}
  ( foo
  )
where

foo :: String
foo = "Deprecated"

-- LibBad.hs
{-# OPTIONS_GHC -Wno-deprecations #-}

module LibBad (foo) where

import Deprecated (foo)

-- -Wno-deprecations does not help, foo still deprecated.

-- Main.hs
{-# OPTIONS_GHC -Werror=deprecations #-}

module Main (main) where

import LibBad (foo)
--import LibGood (foo) -- this works

main :: IO ()
main = putStrLn foo
```

```
$ cabal run

app/Main.hs:9:17: error: [GHC-68441] [-Wdeprecations, Werror=deprecations]
    In the use of ‘foo’
    (imported from LibBad, but defined in Deprecated):
    Deprecated: "This entire module is deprecated"
  |
9 | main = putStrLn foo
  |          
```

## Good Example

On the other hand, this works:

```haskell
-- LibGood.hs
{-# OPTIONS_GHC -Wno-deprecations #-}

module LibGood (foo) where

import Deprecated qualified

foo :: String
foo = Deprecated.foo ++ " LibGood"

-- LibGood.foo not deprecated since new symbol

-- Main.hs
{-# OPTIONS_GHC -Werror=deprecations #-}

module Main (main) where

--import LibBad (foo)
import LibGood (foo) -- this works

main :: IO ()
main = putStrLn foo
```

```
$ cabal run
Deprecated LibGood
```