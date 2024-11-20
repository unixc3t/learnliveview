# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Demo.Repo.insert!(%Demo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Demo.Repo
alias Demo.Servers.Server

%Server{
  name: "dancing-lizard",
  status: "up",
  size: 19.5,
  git_repo: "https://git.example.com/dancing-lizard.git",
}
|> Repo.insert!()

%Server{
  name: "lively-frog",
  status: "up",
  size: 24.0,
  git_repo: "https://git.example.com/lively-frog.git",
}
|> Repo.insert!()

%Server{
  name: "curious-raven",
  status: "up",
  size: 17.25,
  git_repo: "https://git.example.com/curious-raven.git",
}
|> Repo.insert!()

%Server{
  name: "cryptic-owl",
  status: "down",
  git_repo: "https://git.example.com/cryptic-owl.git",
}
|> Repo.insert!()
