@echo off
setlocal

REM ============================================================================
REM  Copyright © 2025 Sigmology GmbH. All rights reserved.
REM
REM  This software and its associated source code are the proprietary and
REM  confidential property of Sigmology GmbH.
REM  Unauthorized reproduction, distribution, modification, or use of this
REM  software, in whole or in part, is strictly prohibited without prior
REM  written consent from Sigmology GmbH.
REM
REM  This software is licensed, not sold. Use of this software is subject to
REM  the terms and conditions specified in the applicable license agreement.
REM
REM  For licensing inquiries, please contact info@sigmology.ch.
REM ============================================================================

set "COMPOSE_FILE=docker-compose.yaml"

docker compose -f "%COMPOSE_FILE%" down --remove-orphans
if errorlevel 1 (
    echo ❌ Failed to stop SuprVision stack.
    exit /b 1
)

echo ✅ SuprVision stack stopped successfully.

endlocal
