module Lib
  ( -- * Pure exception
    pureEx,
    pureExExtra,

    -- * IO exception
    ioEx,
    ioExExtra,

    -- * IO + Hcs
    ioExHcs,
    ioExExtraHcs,

    -- * Exception thrown in dependency
    depEx,
    depExExtra,

    -- * Dependency + Hcs
    depExHcs,
    depExExtraHcs,
  )
where

import Control.Monad (void)
import Data.Text (Text)
import Data.Text qualified as T
import Data.Text.Encoding qualified as TEnc
import Data.Text.IO qualified as TIO
import GHC.Stack.Types (HasCallStack)

--------------------------------------------------------------------------------
-------------------------------- Pure exception --------------------------------
--------------------------------------------------------------------------------

oops :: Text
oops = TEnc.decodeUtf8 "語"

pureEx :: IO ()
pureEx = putStrLn $ T.unpack oops

pureExExtra :: IO ()
pureExExtra = do
  putStrLn "In pureExExtra"
  putStrLn $ T.unpack oops
  pure ()

--------------------------------------------------------------------------------
--------------------------------- IO exception ---------------------------------
--------------------------------------------------------------------------------

readBadFile :: IO String
readBadFile = readFile "bang"

ioEx :: IO ()
ioEx = void readBadFile

ioExExtra :: IO ()
ioExExtra = do
  putStrLn "In ioExExtra"
  _ <- readBadFile
  pure ()

--------------------------------------------------------------------------------
----------------------------------- IO + Hcs -----------------------------------
--------------------------------------------------------------------------------

readBadFileHcs :: (HasCallStack) => IO String
readBadFileHcs = readFile "bang"

ioExHcs :: (HasCallStack) => IO ()
ioExHcs = void readBadFileHcs

ioExExtraHcs :: (HasCallStack) => IO ()
ioExExtraHcs = do
  putStrLn "In ioExExtraHcs"
  _ <- readBadFileHcs
  pure ()

--------------------------------------------------------------------------------
------------------------------------ Dep Ex ------------------------------------
--------------------------------------------------------------------------------

readBadFileText :: IO String
readBadFileText = T.unpack <$> TIO.readFile "bang"

depEx :: IO ()
depEx = void readBadFileText

depExExtra :: IO ()
depExExtra = do
  putStrLn "In depExExtra"
  _ <- readBadFileText
  pure ()

--------------------------------------------------------------------------------
----------------------------------- Dep + Hcs ----------------------------------
--------------------------------------------------------------------------------

readBadFileTextHcs :: (HasCallStack) => IO String
readBadFileTextHcs = T.unpack <$> TIO.readFile "bang"

depExHcs :: (HasCallStack) => IO ()
depExHcs = void readBadFileTextHcs

depExExtraHcs :: (HasCallStack) => IO ()
depExExtraHcs = do
  putStrLn "In depExExtraHcs"
  _ <- readBadFileTextHcs
  pure ()
