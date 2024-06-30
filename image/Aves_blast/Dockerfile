FROM python:3

ENV DEBIAN_FRONTEND noninteractive
RUN \
    # sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list.d/debian.sources && \
    # sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list.d/debian.sources && \
    # sed -i 's/security-cdn.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list.d/debian.sources && \
    sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    sed -i 's/security-cdn.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
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

ADD https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.15.0+-x64-linux.tar.gz /usr/local/src
# ADD ncbi-blast-2.15.0+-x64-linux.tar.gz /usr/local/src

ENV PATH="$PATH:/usr/local/src/ncbi-blast-2.15.0+/bin"
RUN mkdir -p /usr/local/src/blast && \
    tar xvf /usr/local/src/ncbi-blast-2.15.0+-x64-linux.tar.gz -C /usr/local/src/ && \
    rm -f /usr/local/src/ncbi-blast-2.15.0+-x64-linux.tar.gz


ARG ROOT_DIR=$ROOT_DIR

# Copy the Laravel application files into the container.
ADD ${ROOT_DIR}/projects/aves_blast /app

WORKDIR /app

# VOLUME /app/blast_res
# VOLUME /app/blast_seq
# VOLUME /app/seq_info

ENTRYPOINT python3 task.py
