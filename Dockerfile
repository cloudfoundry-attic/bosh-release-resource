FROM concourse/buildroot:ruby

ADD gems /tmp/gems

RUN  set -ex \
  && gem install /tmp/gems/*.gem --no-document \
  && gem install bosh_cli -v 1.3202.0 --no-document

ADD . /tmp/resource-gem

RUN  set -ex \
  && cd /tmp/resource-gem \
  && gem build *.gemspec && gem install *.gem --no-document \
  && mkdir -p /opt/resource \
  && ln -s $(which brr_in) /opt/resource/in \
  && ln -s $(which brr_out) /opt/resource/out
