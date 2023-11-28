{-# OPTIONS_GHC -Werror=deprecations #-}

module Main (main) where

import LibBad (foo)
-- import LibGood (foo) -- this works

main :: IO ()
main = putStrLn foo
