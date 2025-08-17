#!/bin/bash

# ============================================================================
#  Copyright © 2025 Sigmology GmbH. All rights reserved.
#
#  This software and its associated source code are the proprietary and
#  confidential property of Sigmology GmbH.
#  Unauthorized reproduction, distribution, modification, or use of this
#  software, in whole or in part, is strictly prohibited without prior
#  written consent from Sigmology GmbH.
#
#  This software is licensed, not sold. Use of this software is subject to
#  the terms and conditions specified in the applicable license agreement.
#
#  For licensing inquiries, please contact info@sigmology.ch.
# ============================================================================

set -euo pipefail

# Require .env and export its vars
[ -f .env ] || { echo "❌ .env not found"; exit 1; }
set -a
. ./.env
set +a

# Require creds
: "${DOCKERHUB_USERNAME:?Set DOCKERHUB_USERNAME in .env}"
: "${DOCKERHUB_PASSWORD:?Set DOCKERHUB_PASSWORD in .env}"

# Defaults
AGENT_SCALE="${AGENT_SCALE:-4}"
COMPOSE_FILE="docker-compose.yaml"

# Login
printf "%s" "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin

# Bring stack up & scale agents
docker compose -f "$COMPOSE_FILE" up -d --scale agent="$AGENT_SCALE"

# Logout (do this at the end to avoid issues if compose pulls during 'up')
docker logout || true

# Success message
echo "✅ SuprVision stack started successfully."
