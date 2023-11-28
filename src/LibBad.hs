{-# OPTIONS_GHC -Wno-deprecations #-}

module LibBad (foo) where

import Deprecated (foo)

-- -Wno-deprecations does not help, foo still deprecated.
