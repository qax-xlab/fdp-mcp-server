FROM ghcr.io/astral-sh/uv:0.7.13-python3.13-bookworm

WORKDIR /app

COPY . /app

RUN uv sync

CMD ["uv", "run", "--project", "/app", "fdp-mcp-server"]
