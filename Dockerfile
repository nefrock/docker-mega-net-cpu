FROM nefrock/docker-ai-base-cpu:latest
MAINTAINER siwazaki@nefrock.com

RUN pip install sklearn
RUN pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.9.0rc0-cp27-none-linux_x86_64.whl

RUN pip install chainer
RUN pip install pyzmq --install-option="--zmq=bundled"
RUN pip install msgpack-python
RUN apt-get update && apt-get install -y emacs zsh

