module Main (main) where

import Control.Exception.Backtrace
  ( BacktraceMechanism (HasCallStackBacktrace, IPEBacktrace),
    setBacktraceMechanismState,
  )
import Lib qualified as Lib
import System.Environment (getArgs)
import System.Exit (die)

main :: IO ()
main = do
  setBacktraceMechanismState HasCallStackBacktrace False
  setBacktraceMechanismState IPEBacktrace True

  args <- getArgs
  case args of
    ["pure"] -> Lib.pureEx
    ["pure", "extra"] -> Lib.pureExExtra
    ["io"] -> Lib.ioEx
    ["io", "extra"] -> Lib.ioExExtra
    ["hcs"] -> Lib.ioExHcs
    ["hcs", "extra"] -> Lib.ioExExtraHcs
    ["dep"] -> Lib.depEx
    ["dep", "extra"] -> Lib.depExExtra
    ["dep", "hcs"] -> Lib.depExHcs
    ["dep", "extra", "hcs"] -> Lib.depExExtraHcs
    other -> die $ "Unexpected args: " ++ show other
