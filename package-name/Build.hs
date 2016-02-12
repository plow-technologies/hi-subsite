#!/usr/bin/env runhaskell
-- stack --resolver lts-5.0 runghc --package turtle
import           Development.Shake
import           Development.Shake.Command
import           Development.Shake.FilePath
import           Development.Shake.Util

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="_build"} $ do
           wants
           "static" %> \_ -> do
             cmd "git submodule add --name static https://github.com/plow-technologies/onping-static.git ./static"
  where
   wants = want ["static","dist"]
