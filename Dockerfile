FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y curl python && \
    rm -rf /var/lib/apt/lists/*

RUN curl -s https://shopify.github.io/themekit/scripts/install.py | python
RUN apt install git

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
