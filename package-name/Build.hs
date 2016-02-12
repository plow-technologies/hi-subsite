#!/usr/bin/env runhaskell

import           Data.Monoid
import           Development.Shake
import           Development.Shake.Command
import           Development.Shake.FilePath
import           Development.Shake.Util


-- main build
main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="_build", shakeVerbosity=Diagnostic} $ do
           wants
           rules
  where
   wants = want [static]
   static = "static"

   rules = staticRule
   staticRule = static %> \out -> do
     () <- cmd "git submodule add https://github.com/plow-technologies/onping-static.git ./static"
     cmd Shell (Cwd (takeDirectory1 out)) "bower install"


