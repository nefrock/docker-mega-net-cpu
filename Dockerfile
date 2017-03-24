FROM nefrock/docker-ai-base-cpu:latest
MAINTAINER siwazaki@nefrock.com
RUN apt-get update && apt-get install -y emacs zsh libmysqlclient-dev vim
RUN pip install --upgrade pip && pip install \
  moviepy \
  sklearn \
  chainer \
  msgpack-python \
  seaborn \
  tqdm \
  wget \
  sh \
  colorama \
  mysql-python \
  pillow \
  ipykernel
RUN pip3 install --upgrade pip && pip3 install -U setuptools && pip3 install \
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
RUN pip2.7 --no-cache-dir install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.0.0-cp27-none-linux_x86_64.whl
RUN pip3 --no-cache-dir install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.0.0-cp35-cp35m-linux_x86_64.whl
RUN pip2.7 install pyzmq --install-option="--zmq=bundled"
RUN pip3 install pyzmq --install-option="--zmq=bundled"
RUN pip2.7 install --upgrade --no-deps git+git://github.com/Theano/Theano.git
RUN pip3 install --upgrade --no-deps git+git://github.com/Theano/Theano.git
RUN pip install keras==2.0.2
RUN pip3 install keras==2.0.2
