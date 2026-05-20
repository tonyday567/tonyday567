-- | Profile README generator.
-- Usage: runghc app/app.hs
-- Reads nothing; writes readme.md in the current directory.

import Prelude

data Status = CI_Hackage | CI_Only | NoCI_Hackage | None deriving (Eq)

status :: Status -> (Bool, Bool)
status CI_Hackage = (True, True)
status CI_Only = (True, False)
status NoCI_Hackage = (False, True)
status None = (False, False)

ciBadge :: String -> String -> String
ciBadge user repo =
  "[![build](https://github.com/"
    <> user <> "/" <> repo
    <> "/actions/workflows/haskell-ci.yml/badge.svg)](https://github.com/"
    <> user <> "/" <> repo
    <> "/actions/workflows/haskell-ci.yml)"

hackageBadge :: String -> String
hackageBadge repo =
  " [![hackage](https://img.shields.io/hackage/v/"
    <> repo <> ".svg?label=%22%22)](https://hackage.haskell.org/package/" <> repo <> ")"

row :: String -> (String, Status) -> String
row user (repo, s) =
  let (ci, hkg) = status s
  in "|["
    <> repo <> "](https://github.com/" <> user <> "/" <> repo <> ") "
    <> "|![Stars](https://img.shields.io/github/stars/" <> user <> "/" <> repo <> "?style=social) "
    <> "| [![Issues](https://img.shields.io/github/issues/" <> user <> "/" <> repo <> "?label=%22%22)](https://github.com/" <> user <> "/" <> repo <> "/issues) "
    <> "| [![PRs](https://img.shields.io/github/issues-pr/" <> user <> "/" <> repo <> "?label=%22%22)](https://github.com/" <> user <> "/" <> repo <> "/pulls) "
    <> "| " <> (if ci then ciBadge user repo else "")
    <> " |" <> (if hkg then hackageBadge repo else "")
    <> "|\n"

emacsRow :: String -> String -> String
emacsRow user repo =
  "|["
    <> repo <> "](https://github.com/" <> user <> "/" <> repo <> ") "
    <> "|![Stars](https://img.shields.io/github/stars/" <> user <> "/" <> repo <> "?style=social) "
    <> "| [![Issues](https://img.shields.io/github/issues/" <> user <> "/" <> repo <> "?label=%22%22)](https://github.com/" <> user <> "/" <> repo <> "/issues) "
    <> "| [![PRs](https://img.shields.io/github/issues-pr/" <> user <> "/" <> repo <> "?label=%22%22)](https://github.com/" <> user <> "/" <> repo <> "/pulls) |\n"

hlist :: [(String, [(String, Status)])]
hlist =
  [ ("circuits",
      [ ("circuits", CI_Hackage),
        ("circuits-parser", None),
        ("circuits-io", None),
        ("circuits-meter", CI_Hackage),
        ("circuits-llm", None)
      ]),
    ("charts",
      [ ("chart-svg", CI_Hackage),
        ("prettychart", CI_Hackage),
        ("dotparse", CI_Hackage)
      ]),
    ("numhask",
      [ ("numhask", CI_Hackage),
        ("numhask-space", CI_Hackage),
        ("harpie", CI_Hackage),
        ("harpie-numhask", CI_Hackage),
        ("huihua", CI_Hackage)
      ]),
    ("other",
      [ ("formatn", CI_Hackage),
        ("mealy", CI_Hackage),
        ("ephemeral", CI_Hackage)
      ])
  ]

elist :: [(String, [String])]
elist =
  [ ("emacs",
      [ "checklist",
        "doom",
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
