workflow "New workflow" {
  on = "push"
  resolves = ["actions/action-builder/docker@master"]
}

action "Docker Login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_REGISTRY_URL", "DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "actions/action-builder/docker@master" {
  uses = "actions/action-builder/docker@master"
  needs = ["Docker Login"]
  runs = "make"
  args = "build"
}
