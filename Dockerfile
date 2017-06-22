FROM nefrock/docker-ai-base-cpu:latest
MAINTAINER siwazaki@nefrock.com

RUN apt-get update && apt-get install -y emacs zsh libmysqlclient-dev vim

RUN pip install --upgrade pip && pip install -U setuptools && pip3 install \
  moviepy \
  sklearn \
  chainer \
  msgpack-python \
  seaborn \
  tqdm \
  wget \
  sh \
  colorama \
  pillow \
  ipykernel

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

RUN pip --no-cache-dir install \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        scipy \
        sklearn \
        pandas \
        Pillow \
        && \
    python -m ipykernel.kernelspec

RUN apt-get install -y software-properties-common

# setup bazel
RUN add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends openjdk-8-jdk openjdk-8-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN echo "startup --batch" >>/etc/bazel.bazelrc
RUN echo "build --spawn_strategy=standalone --genrule_strategy=standalone" \
    >>/etc/bazel.bazelrc
# Install the most recent bazel release.
ENV BAZEL_VERSION 0.4.5
RUN apt-get update && apt-get install -y unzip
WORKDIR /
RUN mkdir /bazel && \
    cd /bazel && \
    curl -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36" -fSsL -O https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    curl -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36" -fSsL -o /bazel/LICENSE.txt https://raw.githubusercontent.com/bazelbuild/bazel/master/LICENSE && \
    chmod +x bazel-*.sh && \
    ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    cd / && \
    rm -f /bazel/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh

WORKDIR /root

RUN pip install wheel
RUN git clone -b r1.2 https://github.com/tensorflow/tensorflow.git
ENV CI_BUILD_PYTHON python


ENV PYTHON_BIN_PATH /usr/bin/python
RUN cd tensorflow && \
    tensorflow/tools/ci_build/builds/configured CPU \
    bazel build -c opt tensorflow/tools/pip_package:build_pip_package && \
    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/pip && \
    pip --no-cache-dir install --upgrade /tmp/pip/tensorflow-1.2.0*.whl # && \
    rm -rf /tmp/pip && \
    rm -rf /root/.cache



RUN pip install pyzmq --install-option="--zmq=bundled"
RUN pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git
RUN pip install keras==2.0.5
