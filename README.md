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

## Run container from locally built image
```
docker image load -i result
docker run -itd ghcr.io/rschardt/version-replace-container:latest
# get container-name
docker ps
docker attach container-name
cat document.txt
```

## Run container from automatically pushed image
```
docker pull ghcr.io/rschardt/version-replace-container:latest
docker run -itd ghcr.io/rschardt/version-replace-container:latest
# get container-name
docker ps
docker attach container-name
cat document.txt
```
