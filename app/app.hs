{-# LANGUAGE MultilineStrings #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

import Prelude

header :: String
header =
  """Twitter: [@tonyday567](https://twitter.com/tonyday567)"""

haskellSection :: String
haskellSection =
  """

  ## Haskell

  | Name       | Stars  | Issues | PRs    | Status   | Hackage  |
  | ---------- | ------ | ------ | ------ | -------- | -------- |
  """

dataSection :: String
dataSection =
  """

  ## Data Haskell

  | Name       | Stars  | Issues | PRs    | Status   | Hackage  |
  | ---------- | ------ | ------ | ------ | -------- | -------- |
  """

emacsSection :: String
emacsSection =
  """

  ## Emacs

  | Name       | Stars  | Issues | PRs    |
  | ---------- | ------ | ------ | ------ |
  """

data CI = CI | NoCI deriving (Eq)

row :: String -> (String, CI) -> String
row user (repo, ci) =
  """|[#{repo}](https://github.com/#{user}/#{repo}) |![Stars](https://img.shields.io/github/stars/#{user}/#{repo}?style=social) | [![Issues](https://img.shields.io/github/issues/#{user}/#{repo}?label=%22%22)](https://github.com/#{user}/#{repo}/issues) | [![PRs](https://img.shields.io/github/issues-pr/#{user}/#{repo}?label=%22%22)](https://github.com/#{user}/#{repo}/pulls) | #{citext} | [![hackage](https://img.shields.io/hackage/v/#{repo}.svg?label=%22%22)](https://hackage.haskell.org/package/#{repo})|
  """
  where
    citext :: String
    citext = if ci == CI then """[![build](https://github.com/#{user}/#{repo}/actions/workflows/haskell-ci.yml/badge.svg)](https://github.com/#{user}/#{repo}/actions/workflows/haskell-ci.yml)""" else mempty

emacsRow :: String -> String -> String
emacsRow user repo =
  """|[#{repo}](https://github.com/#{user}/#{repo}) |![Stars](https://img.shields.io/github/stars/#{user}/#{repo}?style=social) | [![Issues](https://img.shields.io/github/issues/#{user}/#{repo}?label=%22%22)](https://github.com/#{user}/#{repo}/issues) | [![PRs](https://img.shields.io/github/issues-pr/#{user}/#{repo}?label=%22%22)](https://github.com/#{user}/#{repo}/pulls) |
  """

main :: IO ()
main =
  writeFile "readme.md" $
    header
      <> haskellSection
      <> mconcat
        ( row "tonyday567"
            <$> [ ("numhask", CI),
                  ("numhask-space", CI),
                  ("harpie", CI),
                  ("harpie-numhask", CI),
                  ("chart-svg", CI),
                  ("prettychart", CI),
                  ("dotparse", CI),
                  ("perf", CI),
                  ("box", CI),
                  ("box-socket", CI),
                  ("formatn", CI),
                  ("web-rep", CI),
                  ("mealy", CI),
                  ("huihua", CI),
                  ("ephemeral", CI),
                  ("cabal-fix", CI),
                  ("markup-parse", CI)
                ]
        )
      <> dataSection
      <> mconcat
        [ row "mchav" ("dataframe", NoCI),
          row "hasktorch" ("hasktorch", NoCI),
          row "IHaskell" ("IHaskell", NoCI),
          row "haskell-distributed" ("distributed-process", NoCI),
          row "augustss" ("MicroHs", NoCI),
          row "datahaskell" ("datahaskell-starter", NoCI)
        ]
      <> emacsSection
      <> mconcat
        ( emacsRow "tonyday567"
            <$> [ "checklist",
                  "doom",
                  "ob-haskell-ng",
                  "haskell-lite"
                ]
        )
