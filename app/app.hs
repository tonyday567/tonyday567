{-# language OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# OPTIONS_GHC -Wall #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}

import Prelude
import NeatInterpolation
import qualified Data.Text.IO as Text
import Data.Text (Text)

header :: Text
header =
  [trimming|Twitter: [@tonyday567](https://twitter.com/tonyday567)

## Haskell

| Name | Stars | Issues | Merge Requests | Status | Hackage |
| ---- | ----- | ------ | -------------- | ------ | ------- |
|]

row :: Text -> Text -> Text
row user repo =
  [trimming||$repo |![Stars](https://img.shields.io/github/stars/$user/$repo?style=social) | [![Issues](https://img.shields.io/github/issues/$user/$repo?label=%22%22)](https://github.com/$user/$repo/issues) | [![PRs](https://img.shields.io/github/issues-pr/$user/$repo?label=%22%22)](https://github.com/$user/$repo/pulls) | ![CI](https://github.com/$user/$repo/workflows/haskell-ci/badge.svg) | [![Hackage](https://img.shields.io/hackage/v/$repo.svg?label=%22%22)](https://hackage.haskell.org/package/$repo)
|]

main :: IO ()
main = Text.writeFile "readme.md" $
  header <>
  (mconcat $ row "tonyday567" <$>
  ["chart-svg",
   "numhask",
   "numhask-space",
   "numhask-array",
   "box",
   "perf",
   "poker-fold",
   "hecklist",
   "web-rep",
   "mealy",
   "hcount"
   ])
