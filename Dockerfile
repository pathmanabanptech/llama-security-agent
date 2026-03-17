FROM node:20-slim

# Install Trivy (The Security Scanner)
RUN apt-get update && apt-get install -y curl gnupg lsb-release
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.49.1

# Set working directory
WORKDIR /app

# Copy configuration and local source
COPY mcp-config.json .
COPY package.json .

# Install dependencies
RUN npm install

COPY . .
# Port for the MCP Bridge API
EXPOSE 3000
# The entrypoint is handled by docker-compose