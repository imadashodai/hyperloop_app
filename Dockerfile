FROM centos:6

RUN yum -y update
RUN yum groupinstall -y "Development tools"
RUN yum -y install gcc git tar openssl openssl-devel readline-devel nodejs npm

# nodejs
RUN curl --silent --location https://rpm.nodesource.com/setup_6.x

# rbenvのインストール
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
RUN echo -e 'export PATH=~/.rbenv/bin:$PATH\neval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

# rubyのインストール
ENV CONFIGURE_OPTS --disable-install-doc
RUN ~/.rbenv/plugins/ruby-build/bin/ruby-build 2.3.1 ~/.rbenv/versions/2.3.1

#bundler
RUN echo "install: --no-document" >> /.gemrc; echo "update: --no-document" >> /.gemrc
ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH
RUN eval "$(rbenv init -)"; rbenv global 2.3.1; gem install bundler;

ENV TMPDIR /tmp
WORKDIR $TMPDIR

ADD Gemfile $TMPDIR/Gemfile
ADD Gemfile.lock $TMPDIR/Gemfile.lock

ENV BUNDLE_HOME /var/bundle
RUN mkdir $BUNDLE_HOME
RUN bundle install --path $BUNDLE_HOME --jobs=3

ENV APP_HOME /hyperloop_app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME
RUN bundle install
