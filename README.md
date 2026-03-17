# llama-security-agent
## Autonomous DevSecOps via Local Llama & Model Context Protocol (MCP)
The `llama-security-agent` is a **Privacy-First** autonomous remediation agent. It leverages an internally hosted **Llama 3.1 8B (sLLM)** to analyze vulnerability reports from **Trivy** and autonomously execute code fixes via **GitHub**. 

Built with **Healthcare and Financial Services** compliance in mind, this architecture ensures that proprietary source code and vulnerability data never leave your secure infrastructure.

## Why This Architecture?
In traditional enterprise environments, security is often a reactive **"Context-Switching Tax."** Tools like `npm audit` or Nexus IQ identify risks but leave the high-friction work of triage and remediation to the developer, slowing down velocity and leaving windows of vulnerability open. Furthermore, standard AI security solutions introduce **"Data Exit"** risks by sending proprietary codebases to public LLM APIs a non-starter for high-compliance sectors like Healthcare and Finance.

The **llama-security-agent** solves these challenges by shifting the paradigm from **Reactive Detection to Proactive Immunity**:
- **Ensures Data Privacy:** No source code or vulnerability data ever leaves your network. Uses Llama 3.1 8B for 100% data residency.
- **Proactive Remediation:** Instead of waiting for a post-build alert, the agent identifies and fixes vulnerabilities at the point of inception. It moves the needle from "Shift-Left Detection" to **"Shift-Left Correction."**
- **Reproducible Infrastructure:** Fully containerized via Docker Compose for consistent enterprise deployment.
- **Zero-Friction DevSecOps:** The agent acts as a "Digital Pair Programmer" that handles the grunt work of identifying "Policy-Clean" versions and preparing PRs,  allowing engineers to stay in the "flow state" and focus on feature delivery rather than security debt.

## Tech Stack
- **AI Brain:** Llama 3.1 (8B/70B) via [Ollama](https://ollama.com/)
- **Protocol:** [Model Context Protocol (MCP)](https://modelcontextprotocol.io/docs/getting-started/intro)
- **Security Scanner:** [Trivy](https://trivy.dev/) (Open Source SCA)
- **Automation:** GitHub API (via MCP Server)
- **Runtime:** Node.js / TypeScript

## Getting Started
1. **Prerequisites**

 
  - Docker  & Docker Compose installed.
  - **GitHub PAT:** A token with `repo` permissions.

    *Note: For Apple Silicon users, it is recommended to run Ollama locally to take advantage of Metal GPU acceleration, while the **llama-security-agent** runs containerized via Docker Compose.*
2. **Configuration**

    Create a `.env` file in the root directory:
    ```
    GITHUB_TOKEN=your_gh_token_here
    ```
  
3. **Launch the Agent**
     - Launch llama on your mac: `ollam run llama3.1`
     - Open a Terminal and run:
        ```bash
        OLLAMA_HOST=0.0.0.0 ollama serve
        ``` 
    *(keep this terminal open)*

    - Run the bridge to connect Llama to the MCP tools:
        ```bash
        # Start the containers
        docker-compose up --build -d

        # Verify the agent
        docker logs -f llama-security-agent
        ```
    - Test your Agent
        ```
        curl -X POST http://localhost:8000/prompt \
            -H "Content-Type: application/json" \
            -d '{
            "prompt": "Perform an autonomous security audit. If Trivy finds High/Critical vulnerabilities, fix them by creating a branch and submitting a Pull Request."
            }'
        ```
4. **Example Agent Workflow:**

    Once running, you can prompt the agent (via any MCP-compatible client or the bridge API) with:
    
    "Perform a comprehensive security audit of the repository. Identify all **Critical** and **High** vulnerabilities across all dependencies. For each unique vulnerability, determine the policy-compliant fixed version, branch the code, and prepare an automated remediation Pull Request."

5. **Enterprise Hosting Models:**

As a cloud-native solution, this agent can be scaled across various environments:

- **Local Developer:** Runs as a background service on Apple Silicon or NVIDIA-enabled workstations.
- **Private Cloud (AWS/Azure/GCP):** Hosted on GPU-enabled instances (e.g., EC2 g5.xlarge) within a private VPC.
- **On-Prem Kubernetes:** Deployed as a sidecar to CI/CD runners (Jenkins/GitLab) to provide real-time remediation during the build phase.

## Architectural Design
The agent operates on a **Observe-Orient-Decide-Act (OODA)** loop:

- **Observe:** Reads package.json using GitHub MCP.
- **Orient:** Executes a Trivy scan to identify CVEs and "Fixed Versions."
- **Decide:** Llama reasons if the fix is safe to apply (e.g., no breaking major version changes).
- **Act:** Commits the change and opens a PR with a detailed security summary.

## Security & Privacy
This project was built with Finance and Healthcare grade privacy in mind. By using a Llama instance, we avoid the risks associated with sending proprietary codebases to third-party LLM providers. All tool calls and reasoning happen within your execution environment.

## License
MIT - Clean-room implementation for demonstration purposes.