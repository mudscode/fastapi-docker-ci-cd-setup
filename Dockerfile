# Dockerfile (recommended)
FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1
WORKDIR /app

# system tools for building wheels and for healthcheck
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl build-essential \
 && rm -rf /var/lib/apt/lists/*

# copy project metadata first (cache-friendly)
COPY pyproject.toml poetry.lock* /app/

# upgrade pip & install the package specified by pyproject.toml
RUN python -m pip install --upgrade pip setuptools build wheel \
 && pip install --no-cache-dir .

# copy rest of the source
COPY . /app

EXPOSE 5000

# Run with uvicorn. Change "app:app" if your FastAPI app object is elsewhere.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "5000"]

HEALTHCHECK --interval=30s --timeout=5s CMD curl --fail http://localhost:5000/health || exit 1

LABEL maintainer="Mudassir Ahmad" version="1.0.0" description="FastAPI + Uvicorn app"