FROM ubuntu:18.04

ENV DOWNWARD_REPO /fast-downward
ENV DOWNWARD_BENCHMARKS /downward-benchmarks

RUN apt update -y && apt install -y \
  git \
  mercurial \
  g++ \
  make \
  cmake \
  python3 \
  python3-venv \
  flex \
  bison \
  && apt clean -y

# prepare python
RUN python3 -m venv /venv
ENV PATH /venv/bin:$PATH

# install downward-benchmarks
RUN hg clone https://bitbucket.org/aibasel/downward-benchmarks /downward-benchmarks

# install fast-downward
RUN hg clone http://hg.fast-downward.org /fast-downward
RUN cd /fast-downward && ./build.py

# install downward-lab
RUN hg clone https://bitbucket.org/jendrikseipp/lab /lab
RUN pip install /lab

# install VAL
RUN git clone https://github.com/KCL-Planning/VAL.git /VAL
RUN cd /VAL && make clean && sed -i 's/-Werror //g' Makefile && make
RUN cp /VAL/validate /usr/local/bin
