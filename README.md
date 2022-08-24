# Sample Docker Image

![Publish Docker Image](https://github.com/Borda/docker_sample/workflows/Publish%20Docker%20Image/badge.svg?event=push)
[![Docker Pulls](https://img.shields.io/docker/pulls/borda/docker_sample)](https://hub.docker.com/r/borda/docker_sample)[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/Borda/docker_sample/master.svg)](https://results.pre-commit.ci/latest/github/Borda/docker_sample/master)

## Building with CI/CD

This Docker image a basic image with accent on automatic pushing to Docker Hub.

1. build Docker image in a CI/CD _(for particular version)_
1. test the Image in CI/CD _(for particular version)_
1. push the Image to Docker Hub _**(from master only and if credentials are given)**_

The reason is that DockerHub builds are using weak machines and the build time is very limited compare to GH Actions / CircleCI where you can use up to 5 hours.

### Using Github Actions

Advantage of this build is usage of layer caching with sync with Docker Hub, so you build only the changed Docker layers...

The credentials (`DOCKERHUB_USERNAME` and `DOCKER_PASSWORD`) has to be set in [Github setting - secrets](https://docs.github.com/en/free-pro-team@latest/actions/reference/encrypted-secrets).

### Using CircleCI

It was dropped for some minor compatibility issues... to check it out pls see Git history.

______________________________________________________________________

## Building locally

You can build it on your own, note it takes lots of time, be prepared.

```bash
git clone <git-repository>
cd docker_sample
docker image build -t ubuntu:py36 -f Dockerfile --build-arg PYTHON_VERSION=3.6 .
```

To run build image use following.

```bash
docker image list
docker run --rm -it ubuntu:py36 bash
docker image rm ubuntu:py36
```

### Cleaning

In case you fail with some builds, you may need to clean your local storage.

```bash
docker image prune
```

or [Docker - How to cleanup (unused) resources](https://gist.github.com/bastman/5b57ddb3c11942094f8d0a97d461b430)

```bash
docker images | grep "none"
docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')
```

or remove all - [Some way to clean up](https://forums.docker.com/t/some-way-to-clean-up-identify-contents-of-var-lib-docker-overlay/30604)

```bash
docker rm -vf $(docker ps -aq)
docker rmi -f $(docker images -aq)
docker volume prune -f
```
