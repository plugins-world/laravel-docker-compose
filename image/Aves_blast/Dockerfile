FROM python:3

ENV DEBIAN_FRONTEND noninteractive
RUN \
    # mac
    sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list.d/debian.sources && \
    sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list.d/debian.sources && \
    sed -i 's/security-cdn.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list.d/debian.sources && \

    # vm
    # sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    # sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    # sed -i 's/security-cdn.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    apt update && apt install -y \
    unzip zip

RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple/ && \
    pip3 config set install.trusted-host pypi.tuna.tsinghua.edu.cn

RUN \
    python -m pip install --upgrade pip && \
    pip install \
    pika \
    pandas \
    requests \
    docxtpl \
    openpyxl \
    sqlalchemy \
    pymysql

ARG ROOT_DIR=$ROOT_DIR

ARG NCBI_BLAST_VERSION=2.16.0
ADD ${ROOT_DIR}/image/aves_blast/ncbi-blast-${NCBI_BLAST_VERSION}+-x64-linux.tar.gz /usr/local/src

ADD https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-${NCBI_BLAST_VERSION}+-x64-linux.tar.gz /usr/local/src
RUN tar xvf /usr/local/src/ncbi-blast-${NCBI_BLAST_VERSION}+-x64-linux.tar.gz -C /usr/local/src/ && \
    rm -f /usr/local/src/ncbi-blast-${NCBI_BLAST_VERSION}+-x64-linux.tar.gz

RUN mv /usr/local/src/ncbi-blast-${NCBI_BLAST_VERSION}+ /usr/local/blast/
ENV PATH="$PATH:/usr/local/blast/bin"

# Copy the python application files into the container.
ADD ${ROOT_DIR}/projects/aves_blast /app

WORKDIR /app

# VOLUME /app/blast_res
# VOLUME /app/blast_seq
# VOLUME /app/seq_info

ENTRYPOINT python3 task.py
