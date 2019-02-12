workflow "New workflow" {
  on = "push"
  resolves = ["Docker Tag"]
}

action "Docker Login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_REGISTRY_URL", "DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Build" {
  uses = "actions/action-builder/docker@master"
  needs = ["Docker Login"]
  runs = "make"
  args = "build"
}

action "Docker Tag" {
  uses = "actions/docker/tag@master"
  needs = ["Docker Build"]
  runs = "make"
  args = "tag"
}
