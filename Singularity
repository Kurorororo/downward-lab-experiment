Bootstrap: docker
From: ubuntu:18.04
Stage: build

%environment
    export DOWNWARD_REPO=/fast-downward
    export DOWNWARD_BENCHMARKS=$HOME/downward-benchmarks

%post
    apt update -y
    apt install -y \
      git \
      mercurial \
      g++ \
      make \
      cmake \
      python3 \
      python3-venv \
      flex \
      bison

    python3 -m venv /lab-venv
    . /lab-venv/bin/activate
    echo '. /lab-venv/bin/activate' >> $SINGULARITY_ENVIRONMENT

    hg clone http://hg.fast-downward.org /fast-downward
    cd /fast-downward && ./build.py

    hg clone https://bitbucket.org/jendrikseipp/lab /lab
    pip install /lab

    git clone https://github.com/KCL-Planning/VAL.git /VAL
    cd /VAL && make clean && sed -i 's/-Werror //g' Makefile && make
    cp /VAL/validate /usr/local/bin

