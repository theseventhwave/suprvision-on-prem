# SuprVision AI On-Prem Trial

Welcome to the **SuprVision AI On-Prem Trial**. This repository provides a simple Docker Compose setup that allows potential customers to evaluate SuprVision AI locally, within their own infrastructure, before making a purchase decision.

## About SuprVision AI

SuprVision AI is an **AI-driven, no-code test automation platform** that drastically accelerates test creation—automating complex test scenarios in minutes rather than hours or days. By enabling plain-English test writing and eliminating scripting, it lowers barriers for QA teams and business users alike. Its self-adaptive agents intelligently adjust to application changes, reducing maintenance and improving reliability, while smart, AI‑powered reports deliver real-time feedback from test results to executive-level summaries. This platform balances automation with human-guided control for precise, efficient quality assurance.

Learn more at [www.suprvision.ai](https://www.suprvision.ai).

For inquiries, reach us at: [team@suprvision.ai](mailto\:team@suprvision.ai)

## Prerequisites

To get started, ensure you have the following installed on your system:

- [Docker](https://docs.docker.com/get-docker/)
    - On Windows or macOS, install **Docker Desktop** and ensure it is running.
    - On Linux, follow the instructions for your distribution, and make sure your user is added to the `docker` group if needed.
- [Git](https://git-scm.com/downloads)
    - On Windows, you can install **Git for Windows** (which includes Git Bash).
    - On macOS, Git is often already available; otherwise install via Homebrew (`brew install git`).
    - On Linux, use your package manager (e.g., `apt install git` or `yum install git`).

## Environment Configuration

SuprVision AI requires a configuration file to run properly. This is provided via a `.env` file in the project root.

- You will receive a customer-specific `.env` file from Sigmology GmbH.
- Save the file in the root directory of this project (next to `docker-compose.yaml`).

## Environment Variables in `.env`

The `.env` file controls how your on‑premise trial is configured. It has three sections:

- **These variables should not be changed**: Internal defaults that ensure the application runs properly.

    - `SPRING_PROFILES_ACTIVE` — activates the correct Spring Boot profiles for local Docker and on‑prem setup.
    - `SCREEN_GEOMETRY` and `VIEWPORT_SIZE` — default display settings for test agents.
    - `BUILD_NUMBER` — fixed to `latest` for on‑prem deployments.
    - `AGENT_IMAGE_NAME` — the Docker image name used for the agent.
    - `INGRESS_PORT` — the external port where the application will be accessible (default: `4201`).

- **These variables should be set up once per customer**: Credentials and endpoints unique to each trial customer.

    - `OPENAI_API_KEY` — trial API key for OpenAI.
    - `MONGO_DB_URI` — customer‑specific Mongo Atlas database connection string.
    - `COGNITO_CLIENT_ID` and `AWS_USER_POOL_ID` — identifiers for authentication via AWS Cognito.
    - `DOCKERHUB_USERNAME` and `DOCKERHUB_PASSWORD` — credentials to pull Docker images.

- **These variables may be configured by or for the customer**: Optional settings to customize the deployment.

    - `AGENT_SCALE` — number of agent containers to start (default: `4`). This should cover two factors: (1) the number of users concurrently debugging, and (2) the number of agents needed for parallel execution of test jobs.

## User Accounts

1. The test tenant is set up by Sigmology, including the initial user account.
2. Additional user accounts can be created upon request.

## Setup Instructions

1. **Clone the repository**:

   ```bash
   git clone https://github.com/theseventhwave/suprvision-on-prem.git
   cd suprvision-onprem
   ```

2. **Place your ****\`\`**** file** (provided by Sigmology) into the project root.

3. **Start the application**:

    - On **Linux/macOS**:
      ```bash
      ./start.sh
      ```
    - On **Windows**:
      ```powershell
      start.bat
      ```

   By default, the setup will start 4 agent containers. You can adjust this by editing the `AGENT_SCALE` value in your `.env` file.

4. **Stop the application**:

    - On **Linux/macOS**:
      ```bash
      ./stop.sh
      ```
    - On **Windows**:
      ```powershell
      stop.bat
      ```

Once started, SuprVision AI will be accessible via your browser at:

```
http://localhost:4201
```
