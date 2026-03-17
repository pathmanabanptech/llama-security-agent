FROM python:3.11-slim

# Install Trivy (The Security Scanner)
RUN apt-get update && apt-get install -y curl gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs ca-certificates tar \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin

# Install the Bridge using pip
RUN pip install --no-cache-dir ollama-mcp-bridge

# Set working directory
WORKDIR /app

# Copy configuration and local source
COPY mcp-config.json .
COPY agent_prompt.md .

COPY my-demo-app/package*.json ./

# Install dependencies
RUN npm install

COPY . .
# Port for the MCP Bridge API
EXPOSE 8000
# The entrypoint is handled by docker-compose