# Lint toolchain image for the APM mods: Factorio headless, lua-language-server, the
# Factorio LuaLS types (FMTK) and Python. It contains no repo code: the repo is mounted
# read-only at /repo when the container runs, and tools/lint/lint.py is run from there,
# so changes to the lint scripts need no rebuild.
#
# Built and run by lint.ps1 in the repo root. By hand:
#   docker build -t apm-lint:2.1.20 --build-arg FACTORIO_VERSION=2.1.20 tools/lint
#   docker run --rm -v "<repo>:/repo:ro" -v "<repo>/lint-report:/out" \
#              -v apm-lint-cache:/cache -v "<factorio mods>:/mods:ro" apm-lint:2.1.20

ARG FACTORIO_VERSION=2.1.20
ARG LUALS_VERSION=3.15.0

# ---- Factorio headless server (includes base, space-age, quality, elevated-rails data) ----
FROM debian:bookworm-slim AS factorio
ARG FACTORIO_VERSION
RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl xz-utils \
 && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL -o /tmp/factorio.tar.xz "https://factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64" \
 && tar -xf /tmp/factorio.tar.xz -C /opt \
 && rm /tmp/factorio.tar.xz \
 && mkdir -p /opt/factorio/doc-html /opt/factorio/config \
 && printf 'config-path=__PATH__executable__/../../config\nuse-system-read-write-data-directories=false\n' \
      > /opt/factorio/config-path.cfg \
 && test -f /opt/factorio/data/base/info.json

# ---- API JSON of this Factorio version + LuaLS types generated from it (FMTK) ----
FROM node:22-bookworm-slim AS types
ARG FACTORIO_VERSION
RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /api
RUN curl -fsSL -o runtime-api.json "https://lua-api.factorio.com/${FACTORIO_VERSION}/runtime-api.json" \
 && curl -fsSL -o prototype-api.json "https://lua-api.factorio.com/${FACTORIO_VERSION}/prototype-api.json"
RUN npx --yes --package factoriomod-debug fmtk luals-addon -d runtime-api.json -p prototype-api.json /types \
 && test -f /types/factorio/plugin.lua

# ---- lua-language-server ----
FROM debian:bookworm-slim AS luals
ARG LUALS_VERSION
RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl \
 && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /opt/luals \
 && curl -fsSL "https://github.com/LuaLS/lua-language-server/releases/download/${LUALS_VERSION}/lua-language-server-${LUALS_VERSION}-linux-x64.tar.gz" \
    | tar -xz -C /opt/luals \
 && /opt/luals/bin/lua-language-server --version

# ---- final image ----
FROM python:3.12-slim-bookworm
ARG FACTORIO_VERSION
COPY --from=factorio /opt/factorio /opt/factorio
COPY --from=types /api/runtime-api.json /api/prototype-api.json /opt/factorio/doc-html/
COPY --from=types /types/factorio /opt/factorio-types
COPY --from=luals /opt/luals /opt/luals
# lint.py only runs with these set
ENV APM_LINT_FACTORIO=/opt/factorio \
    APM_LINT_LUALS=/opt/luals/bin/lua-language-server \
    APM_LINT_TYPES=/opt/factorio-types \
    APM_LINT_CACHE=/cache \
    APM_LINT_EXTRA_MODS=/mods \
    APM_LINT_REPORT=/out/lint-report.md \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1
LABEL org.opencontainers.image.title="apm-lint" factorio.version="${FACTORIO_VERSION}"
RUN mkdir -p /cache /out /mods
VOLUME ["/cache"]
WORKDIR /repo
ENTRYPOINT ["python3", "/repo/tools/lint/lint.py"]
