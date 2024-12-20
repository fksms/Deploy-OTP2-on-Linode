#!/bin/bash

# Google Driveからビルド済みの"graph.obj"のダウンロードを行う
# 参考：https://gist.github.com/tanaikech/f0f2d122e05bf5f971611258c22c110f
fileId="1JaYqtkl47JgbwGUA258aILdint3ZD2GY"
curl "https://drive.usercontent.google.com/download?id=${fileId}&confirm=xxx" -o graph.obj