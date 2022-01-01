{-# language OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# OPTIONS_GHC -Wall #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}

import Prelude
import NeatInterpolation
import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import Data.Text (Text)

header :: Text
header =
  [trimming|Twitter: [@tonyday567](https://twitter.com/tonyday567)

## Haskell

| Name | Stars | Issues | Merge Requests | Status | Hackage |
| ---- | ----- | ------ | -------------- | ------ | ------- |

|]

data CI = CI | NoCI deriving (Eq)

row :: Text -> (Text, CI) -> Text
row user (repo, ci) =
  [trimming||$repo |![Stars](https://img.shields.io/github/stars/$user/$repo?style=social) | [![Issues](https://img.shields.io/github/issues/$user/$repo?label=%22%22)](https://github.com/$user/$repo/issues) | [![PRs](https://img.shields.io/github/issues-pr/$user/$repo?label=%22%22)](https://github.com/$user/$repo/pulls) | $citext | [![Hackage](https://img.shields.io/hackage/v/$repo.svg?label=%22%22)](https://hackage.haskell.org/package/$repo)|
|]
    where
      citext = if ci==CI then [trimming|![CI](https://github.com/$user/$repo/workflows/haskell-ci/badge.svg)|] else mempty

main :: IO ()
main = Text.writeFile "readme.md" $
  header <> "\n" <>
  (Text.intercalate "\n" $ row "tonyday567" <$>
  [("chart-svg",CI),
   ("numhask",CI),
   ("numhask-space",CI),
   ("numhask-array",CI),
   ("box",CI),
   ("perf",CI),
   ("poker-fold",NoCI),
   ("hecklist",NoCI),
   ("web-rep",CI),
   ("mealy",CI),
   ("hcount",NoCI)
   ])
