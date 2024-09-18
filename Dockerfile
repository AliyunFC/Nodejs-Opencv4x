FROM registry.cn-beijing.aliyuncs.com/aliyunfc/runtime-custom.debian10

ARG OPENCV_VERSION=4.5.1

# Install Pre-requisites
RUN apt-get update && apt-get install -y curl wget build-essential g++ cmake unzip

# Download OpenCV
RUN mkdir -p opencv && \
    cd opencv && \
    wget -O opencv.zip https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \
    unzip opencv.zip

# Download OpenCV Contrib
# RUN cd opencv && \
#     wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip && \
#     unzip opencv_contrib.zip

# 创建opencv的安装目录和opt目录
RUN mkdir -p /usr/local/opencv && \
    mkdir -p /opt

# Configure OpenCV
RUN cd opencv && \
    mkdir -p build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local/opencv \
    -D BUILD_DOCS=OFF \
    -D BUILD_TESTS=OFF \
    -D BUILD_PERF_TESTS=OFF \
    -D BUILD_JAVA=OFF \
    -D BUILD_opencv_apps=OFF \
    -D BUILD_opencv_aruco=OFF \
    -D BUILD_opencv_bgsegm=OFF \
    -D BUILD_opencv_bioinspired=OFF \
    -D BUILD_opencv_ccalib=OFF \
    -D BUILD_opencv_datasets=OFF \
    -D BUILD_opencv_dnn_objdetect=OFF \
    -D BUILD_opencv_dpm=OFF \
    -D BUILD_opencv_fuzzy=OFF \
    -D BUILD_opencv_hfs=OFF \
    -D BUILD_opencv_java_bindings_generator=OFF \
    -D BUILD_opencv_js=OFF \
    -D BUILD_opencv_img_hash=OFF \
    -D BUILD_opencv_line_descriptor=OFF \
    -D BUILD_opencv_optflow=OFF \
    -D BUILD_opencv_phase_unwrapping=OFF \
    -D BUILD_opencv_python3=OFF \
    -D BUILD_opencv_python_bindings_generator=OFF \
    -D BUILD_opencv_reg=OFF \
    -D BUILD_opencv_rgbd=OFF \
    -D BUILD_opencv_saliency=OFF \
    -D BUILD_opencv_shape=OFF \
    -D BUILD_opencv_stereo=OFF \
    -D BUILD_opencv_stitching=OFF \
    -D BUILD_opencv_structured_light=OFF \
    -D BUILD_opencv_superres=OFF \
    -D BUILD_opencv_surface_matching=OFF \
    -D BUILD_opencv_ts=OFF \
    -D BUILD_opencv_xobjdetect=OFF \
    -D BUILD_opencv_xphoto=OFF \
    -D BUILD_EXAMPLES=OFF ../opencv-${OPENCV_VERSION}

# Compile OpenCV
RUN cd opencv/build && \ 
    cmake --build . --config Release

# Install OpenCV
RUN cd opencv/build && \
    make install

# 拷贝安装产物到/opt目录
RUN cp -r /usr/local/opencv /opt

# 将/opt目录下的文件打包成ZIP格式的压缩包。注意添加-y参数保留软链接。
# .[^.]* 表示包含隐藏文件并排除父目录。
RUN cd /opt && zip -ry layer.zip * .[^.]*

CMD ["bash"]