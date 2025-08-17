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

COMPOSE_FILE="docker-compose.yaml"

docker compose -f "$COMPOSE_FILE" down --remove-orphans
