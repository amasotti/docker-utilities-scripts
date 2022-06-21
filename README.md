# docker-utilities-script
Too lazy to write everything from scratch every time


This repo will be a continuous Work-in-progress to save simple scripts to interact with docker containers, volumes, images. Nothing ambitious, just a way to spare time.


## Requirements

- Bash Shell (v.4 at least)
- [jq](https://stedolan.github.io/jq/) for parsing JSON outputs

## Scripts

- `inspect-and-list-volumes-data.sh` : List infos about available volumes and list persisted files (`ls -Alh "${VOLUME_MOUNTING_POINT}"`). Writes the outpu to a text file.
