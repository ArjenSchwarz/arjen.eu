workflow "Build and Deploy Hugo Site" {
  on = "push"
  resolves = ["GitHub Pages"]
}

action "Build" {
  uses = "ArjenSchwarz/actions/hugo/build@master"
  secrets = ["GITHUB_TOKEN"]
}

action "GitHub Pages" {
  needs = ["Build"]
  uses = "ArjenSchwarz/actions/github/pages@master"
  args = "--cf-invalidate --default-mime-type=application/json"
  secrets = ["GITHUB_TOKEN"]
  env = {
    ONLY_IN_BRANCH = "master"
  }
}
