FROM centos:8

# Copy required scripts.
COPY scripts /opt/scripts

# Install dependencies.
RUN /opt/scripts/install-dependencies.sh \
  && /opt/scripts/install-libyang.sh \
  && /opt/scripts/setup-environment.sh

# Run entrypoint.
VOLUME /build/frr
WORKDIR /build/frr
