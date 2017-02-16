FROM nefrock/docker-ai-base-cpu:latest
MAINTAINER siwazaki@nefrock.com
RUN apt-get update && apt-get install -y emacs zsh libmysqlclient-dev vim
RUN pip install --upgrade pip
RUN pip install \
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
  pillow
RUN pip --no-cache-dir install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.12.1-cp27-none-linux_x86_64.whl
RUN pip install pyzmq --install-option="--zmq=bundled"
RUN pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git
