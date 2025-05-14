FROM n8nio/base:20 as base

# Install system dependencies in a single RUN command
RUN apk add --no-cache --update openssh sudo shadow bash
RUN echo node ALL=(root) NOPASSWD:ALL > /etc/sudoers.d/node && \
    chmod 0440 /etc/sudoers.d/node && \
    mkdir /workspaces && chown node:node /workspaces

# Create a separate stage for the application
FROM base as app
USER node
RUN mkdir -p ~/.pnpm-store && pnpm config set store-dir ~/.pnpm-store --global
