#!/usr/bin/env runhaskell

-- stack --resolver lts-5.0 runghc --package turtle
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
   wants = want ["static","static/js"]
   rules = staticRule >> jsBuildRule
   staticRule = "static" %> \_ -> do
                  cmd "git submodule add --name static https://github.com/plow-technologies/onping-static.git ./static"
   jsBuildRule = "static/js" %> \out -> do
                  let bowerjson = takeDirectory1 out </>"bower" <.> "json"
                  need [bowerjson]
                  cmd Shell (Cwd (takeDirectory1 out)) "bower install"
