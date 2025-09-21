# Builder image
FROM elixir:1.15-slim AS builder

# Install build dependencies
RUN apt-get update && apt-get install -y build-essential git && \
    apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set the working directory
WORKDIR /app

# Install Hex and Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy the application files
COPY mix.exs mix.lock ./
COPY config config
COPY deps deps
COPY assets assets
COPY lib lib
COPY priv priv

# Set the environment to prod
ENV MIX_ENV=prod

# Fetch dependencies
RUN mix deps.get --only prod
RUN mix deps.compile

# Compile the application
RUN mix compile

# Build assets
RUN mix assets.deploy

# Generate release
RUN mix release

# Final image
FROM elixir:1.15-slim

# Set the working directory
WORKDIR /app

# Copy the release from the builder
COPY --from=builder /app/_build/prod/rel/myapp .

# Expose the application port
EXPOSE 4000

# Set the entrypoint
ENTRYPOINT ["/app/bin/myapp", "start"]
