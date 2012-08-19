#!/bin/bash

OUT_DIR="./out/"
CONTENT_DIR="./out/content"
VIEW_DIR="./out/view"

if [ ! -d "$OUT_DIR" ]; then
    mkdir "$OUT_DIR"
fi

coffee -c -o "$OUT_DIR" ./src/

if [ ! -d "$CONTENT_DIR" ]; then
    mkdir "$CONTENT_DIR"
fi

if [ ! -d "$VIEW_DIR" ]; then
    mkdir "$VIEW_DIR"
fi

cp ./src/content/* "$CONTENT_DIR"
cp ./src/view/* "$VIEW_DIR"

node ./out/main.js