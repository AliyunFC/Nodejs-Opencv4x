参考：  
https://help.aliyun.com/zh/functioncompute/use-a-dockerfile-to-build-a-layer-1?spm=a2c4g.11186623.0.0.22ba13a7Bn15as

https://github.com/fanzhe328/fc-layer/blob/main/layers/puppeteer-lib/Dockerfile

https://github.com/awesome-fc/awesome-layers/blob/main/layers/Nodejs-Puppeteer17x/Dockerfile

https://github.com/justadudewhohacks/opencv4nodejs-docker-images/blob/master/opencv-nodejs/Dockerfile

运行：

```
docker build -t opencv -f Dockerfile .
```

提取 ZIP：

```
docker run --rm --entrypoint sh -v "${PWD}:/tmp" opencv -c "cp /opt/opencv-layer-debian10.zip /tmp/"
```

添加环境变量：

```
LD_LIBRARY_PATH: /opt/opencv/lib
OPENCV_INCLUDE_DIR: /opt/opencv/include/opencv4
OPENCV_LIB_DIR: /opt/opencv/lib
OPENCV_BIN_DIR: /opt/opencv/bin
OPENCV4NODEJS_DISABLE_AUTOBUILD: "1"
```
