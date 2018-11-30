FROM debian:9

RUN apt update
RUN apt -y install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev openjdk-8-jdk python

RUN git config --global user.name "TEST test" && \
    git config --global user.email test@test.com && \
    git config --global color.ui false

WORKDIR /usr/local

RUN curl https://dl.google.com/android/repository/platform-tools_r28.0.1-linux.zip | \
            jar x

ENV PATH "/usr/local/platform-tools:/usr/local/bin:$PATH"

RUN echo $PATH

RUN mkdir -p /usr/local/bin

RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo && \
    chmod +x /usr/local/bin/repo

COPY build.sh /

