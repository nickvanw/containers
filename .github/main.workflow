workflow "New workflow" {
  on = "push"
  resolves = ["Docker Tag and Push"]
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

action "Docker Tag and Push" {
  uses = "actions/action-builder/docker@master"
  needs = ["Docker Build"]
  runs = "make"
  args = "publish"
}
