FROM adoptopenjdk/openjdk16

LABEL maintainer "Viktor Adam <rycus86@gmail.com>"

ARG IDEA_VERSION=2020.3
ARG IDEA_BUILD=2020.3.3

RUN  \
  apt-get update && apt-get install --no-install-recommends -y \
  gcc git openssh-client less \
  libxtst-dev libxext-dev libxrender-dev libfreetype6-dev \
  libfontconfig1 libgtk2.0-0 libxslt1.1 libxxf86vm1 \
  && rm -rf /var/lib/apt/lists/* \
  && useradd -ms /bin/bash developer

ARG idea_source=https://download.jetbrains.com/idea/ideaIU-${IDEA_BUILD}.tar.gz
ARG idea_local_dir=.IdeaIU${IDEA_VERSION}

WORKDIR /opt/idea

RUN curl -fsSL $idea_source -o /opt/idea/installer.tgz \
  && tar --strip-components=1 -xzf installer.tgz \
  && rm installer.tgz

USER developer
ENV HOME /home/developer

RUN mkdir /home/developer/.Idea \
  && ln -sf /home/developer/.Idea /home/developer/$idea_local_dir

CMD [ "/opt/idea/bin/idea.sh" ]
