{-# LANGUAGE OverloadedStrings #-}

import Prelude

ciBadge :: String -> String -> String
ciBadge user repo =
  "[![build](https://github.com/"
    <> user
    <> "/"
    <> repo
    <> "/actions/workflows/haskell-ci.yml/badge.svg)](https://github.com/"
    <> user
    <> "/"
    <> repo
    <> "/actions/workflows/haskell-ci.yml)"

row :: String -> (String, Bool) -> String
row user (repo, ci) =
  "|["
    <> repo
    <> "](https://github.com/"
    <> user
    <> "/"
    <> repo
    <> ") |![Stars](https://img.shields.io/github/stars/"
    <> user
    <> "/"
    <> repo
    <> "?style=social) | [![Issues](https://img.shields.io/github/issues/"
    <> user
    <> "/"
    <> repo
    <> "?label=%22%22)](https://github.com/"
    <> user
    <> "/"
    <> repo
    <> "/issues) | [![PRs](https://img.shields.io/github/issues-pr/"
    <> user
    <> "/"
    <> repo
    <> "?label=%22%22)](https://github.com/"
    <> user
    <> "/"
    <> repo
    <> "/pulls) | "
    <> (if ci then ciBadge user repo else "")
    <> " | [![hackage](https://img.shields.io/hackage/v/"
    <> repo
    <> ".svg?label=%22%22)](https://hackage.haskell.org/package/"
    <> repo
    <> ")|\n"

emacsRow :: String -> String -> String
emacsRow user repo =
  "|["
    <> repo
    <> "](https://github.com/"
    <> user
    <> "/"
    <> repo
    <> ") |![Stars](https://img.shields.io/github/stars/"
    <> user
    <> "/"
    <> repo
    <> "?style=social) | [![Issues](https://img.shields.io/github/issues/"
    <> user
    <> "/"
    <> repo
    <> "?label=%22%22)](https://github.com/"
    <> user
    <> "/"
    <> repo
    <> "/issues) | [![PRs](https://img.shields.io/github/issues-pr/"
    <> user
    <> "/"
    <> repo
    <> "?label=%22%22)](https://github.com/"
    <> user
    <> "/"
    <> repo
    <> "/pulls) |\n"

hlist :: [(String, [(String, Bool)])]
hlist =
  [ ("circuits",
      [ ("circuits", True),
        ("circuits-parser", True),
        ("circuits-io", True),
        ("circuits-meter", True)
      ]),
    ("charts",
      [ ("chart-svg", True),
        ("prettychart", True),
        ("dotparse", True)
      ]),
    ("numhask",
      [ ("numhask", True),
        ("numhask-space", True),
        ("harpie", True),
        ("harpie-numhask", True)
      ]),
    ("other",
      [ ("formatn", True),
        ("mealy", True),
        ("huihua", True),
        ("ephemeral", True)
      ])
  ]

elist :: [(String, [String])]
elist =
  [ ("emacs",
      [ "checklist",
        "doom",
        "ob-haskell-ng",
        "haskell-lite"
      ])
  ]

section :: String -> String
section name = "\n## " <> name <> "\n\n| Name | Stars | Issues | PRs | Status | Hackage |\n| ---- | ----- | ------ | --- | ------ | ------- |\n"

emacsHeader :: String
emacsHeader = "\n## emacs\n\n| Name | Stars | Issues | PRs |\n| ---- | ----- | ------ | --- |\n"

main :: IO ()
main =
  writeFile "readme.md" $
    "[![build](https://github.com/tonyday567/circuits/actions/workflows/haskell-ci.yml/badge.svg)](https://github.com/tonyday567/circuits/actions/workflows/haskell-ci.yml)\n\n"
      <> mconcat [section name <> mconcat (row "tonyday567" <$> repos) | (name, repos) <- hlist]
      <> mconcat [emacsHeader <> mconcat (emacsRow "tonyday567" <$> repos) | (name, repos) <- elist]
