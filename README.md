# github-action-codingchallenge

## Replace number in file
```
nix build
# this is the replaced file
cat result/document.txt
```

## Build docker image
```
nix build .\#version-replace-container
```

## Run container
```
docker image load -i result
docker run -itd ghcr.io/rschardt/version-replace-container:latest
# get container-name
docker ps
docker attach container-name
cat document.txt
```
