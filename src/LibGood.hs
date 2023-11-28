{-# OPTIONS_GHC -Wno-deprecations #-}

module LibGood (foo) where

import qualified Deprecated

foo :: String
foo = Deprecated.foo ++ " LibGood"

-- LibGood.foo not deprecated since new symbol
