# Sample Docker Image

[![CircleCI](https://circleci.com/gh/Borda/docker_sample.svg?style=svg)](https://circleci.com/gh/Borda/docker_sample)

This Docker image a i basic image with accent on automatic pushing to Docker Hub.

1. build Docker image in a CI/CD
2. test the Image in CI/CD
3. push the Image to Docker Hub

---

## Building locally

You can build it on your own, note it takes lots of time, be prepared.
```bash
git clone <git-repository>
cd docker_sample
docker image build -t ubuntu:py36 -f Dockerfile --build-arg PYTHON_VERSION=3.6 .
```
To build other versions, select different Dockerfile.
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
  