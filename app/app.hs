{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# OPTIONS_GHC -Wall #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}

import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import NeatInterpolation
import Prelude

header :: Text
header =
  [trimming|Twitter: [@tonyday567](https://twitter.com/tonyday567)|]

haskellSection :: Text
haskellSection =
  [trimming|

## Haskell

| Name | Stars | Issues | Merge Requests | Status | Hackage |
| ---- | ----- | ------ | -------------- | ------ | ------- |

|]

emacsSection :: Text
emacsSection =
  [trimming|

## Emacs

| Name | Stars | Issues | Merge Requests |
| ---- | ----- | ------ | -------------- |

|]

data CI = CI | NoCI deriving (Eq)

row :: Text -> (Text, CI) -> Text
row user (repo, ci) =
  [trimming||[$repo](https://github.com/$user/$repo) |![Stars](https://img.shields.io/github/stars/$user/$repo?style=social) | [![Issues](https://img.shields.io/github/issues/$user/$repo?label=%22%22)](https://github.com/$user/$repo/issues) | [![PRs](https://img.shields.io/github/issues-pr/$user/$repo?label=%22%22)](https://github.com/$user/$repo/pulls) | $citext | [![Hackage](https://img.shields.io/hackage/v/$repo.svg?label=%22%22)](https://hackage.haskell.org/package/$repo)|
|]
  where
    citext = if ci == CI then [trimming|[![CI](https://github.com/$user/$repo/workflows/haskell-ci/badge.svg)](https://github.com/$user/$repo/actions)|] else mempty

emacsRow :: Text -> Text -> Text
emacsRow user repo =
  [trimming||[$repo](https://github.com/$user/$repo) |![Stars](https://img.shields.io/github/stars/$user/$repo?style=social) | [![Issues](https://img.shields.io/github/issues/$user/$repo?label=%22%22)](https://github.com/$user/$repo/issues) | [![PRs](https://img.shields.io/github/issues-pr/$user/$repo?label=%22%22)](https://github.com/$user/$repo/pulls) |
|]

main :: IO ()
main =
  Text.writeFile "readme.md" $
    header
      <> "\n"
      <> haskellSection
      <> "\n"
      <> Text.intercalate
        "\n"
        ( row "tonyday567"
            <$> [ ("chart-svg", CI),
                  ("prettychart", CI),
                  ("color-adjust", NoCI),
                  ("dotparse", NoCI),
                  ("research-hackage", CI),
                  ("numhask", CI),
                  ("numhask-space", CI),
                  ("numhask-array", CI),
                  ("box", CI),
                  ("formatn", CI),
                  ("perf", CI),
                  ("poker-fold", NoCI),
                  ("web-rep", CI),
                  ("mealy", CI)
                ]
        )
      <> emacsSection
      <> "\n"
      <> Text.intercalate
        "\n"
        ( emacsRow "tonyday567"
            <$> [ "checklist",
                  "doom"
                ]
        )
