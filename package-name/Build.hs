#!/usr/bin/env runhaskell

import           Data.Monoid
import           Development.Shake
import           Development.Shake.Command
import           Development.Shake.FilePath
import           Development.Shake.Util
main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="_build"} $ do
           wants
           rules

  where
   wants = want ["static/bower.json","static/js"]
   rules = staticRule >> jsBuildRule
   staticRule = "static/bower.json" %> \_ -> do
                  cmd "git submodule add https://github.com/plow-technologies/onping-static.git ./static"
   jsBuildRule = "static/js" %> \out -> do
                  let bowerjson = takeDirectory1 out </>"bower" <.> "json"
                  need [bowerjson]
                  cmd Shell (Cwd (takeDirectory1 out)) "bower install"
