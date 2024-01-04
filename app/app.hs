{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

import Data.String.Interpolate
import Prelude

header :: String
header =
  [i|Twitter: [@tonyday567](https://twitter.com/tonyday567)|]

haskellSection :: String
haskellSection =
  [i|

\#\# Haskell

| Name       | Stars  | Issues | PRs    | Status   | Hackage  |
| ---------- | ------ | ------ | ------ | -------- | -------- |
|]

emacsSection :: String
emacsSection =
  [i|

\#\# Emacs

| Name       | Stars  | Issues | PRs    |
| ---------- | ------ | ------ | ------ |
|]

data CI = CI | NoCI deriving (Eq)

row :: String -> (String, CI) -> String
row user (repo, ci) =
  [i||[#{repo}](https://github.com/#{user}/#{repo}) |![Stars](https://img.shields.io/github/stars/#{user}/#{repo}?style=social) | [![Issues](https://img.shields.io/github/issues/#{user}/#{repo}?label=%22%22)](https://github.com/#{user}/#{repo}/issues) | [![PRs](https://img.shields.io/github/issues-pr/#{user}/#{repo}?label=%22%22)](https://github.com/#{user}/#{repo}/pulls) | #{citext} | [![Hackage](https://img.shields.io/hackage/v/#{repo}.svg?label=%22%22)](https://hackage.haskell.org/package/#{repo})|
|]
  where
    citext :: String
    citext = if ci == CI then [i|[![CI](https://github.com/#{user}/#{repo}/workflows/haskell-ci/badge.svg)](https://github.com/#{user}/#{repo}/actions)|] else mempty

emacsRow :: String -> String -> String
emacsRow user repo =
  [i||[#{repo}](https://github.com/#{user}/#{repo}) |![Stars](https://img.shields.io/github/stars/#{user}/#{repo}?style=social) | [![Issues](https://img.shields.io/github/issues/#{user}/#{repo}?label=%22%22)](https://github.com/#{user}/#{repo}/issues) | [![PRs](https://img.shields.io/github/issues-pr/#{user}/#{repo}?label=%22%22)](https://github.com/#{user}/#{repo}/pulls) |
|]

main :: IO ()
main =
  writeFile "readme.md" $
    header
      <> haskellSection
      <> mconcat
        ( row "tonyday567"
            <$> [ ("numhask", CI),
                  ("numhask-space", CI),
                  ("numhask-array", CI),
                  ("chart-svg", CI),
                  ("prettychart", CI),
                  ("dotparse", CI),
                  ("perf", CI),
                  ("box", CI),
                  ("box-socket", CI),
                  ("formatn", CI),
                  ("poker-fold", NoCI),
                  ("web-rep", CI),
                  ("mealy", CI),
                  ("cabal-fix", NoCI),
                  ("huihua", NoCI),
                  ("hcount", NoCI),
                  ("anal", NoCI),
                  ("ephemeral", CI),
                  ("cabal-fix", NoCI),
                  ("markup-parse", CI),
                  ("eulerproject", CI)
                ]
        )
      <> emacsSection
      <> mconcat
        ( emacsRow "tonyday567"
            <$> [ "checklist",
                  "doom",
                  "ob-haskell-ng",
                  "haskell-lite"
                ]
        )
