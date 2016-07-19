FROM nefrock/docker-ai-base-cpu:latest
MAINTAINER siwazaki@nefrock.com
RUN apt-get update && apt-get install -y emacs zsh libmysqlclient-dev
RUN pip install sklearn
RUN pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.9.0rc0-cp27-none-linux_x86_64.whl
RUN pip install pyzmq --install-option="--zmq=bundled"
RUN pip install chainer msgpack-python seaborn tqdm wget sh colorama mysql-python
RUN pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git

