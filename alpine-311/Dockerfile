FROM alpine:3.11

# Add scripts dependency.
RUN apk add bash

# Copy required scripts.
COPY scripts /opt/scripts

# Install dependencies.
RUN /opt/scripts/install-dependencies.sh \
  && /opt/scripts/install-libyang.sh \
  && /opt/scripts/setup-environment.sh

# Run entrypoint.
VOLUME /build/frr
WORKDIR /build/frr
