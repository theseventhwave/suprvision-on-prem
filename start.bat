@echo off
setlocal enabledelayedexpansion

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

REM Check .env file
if not exist ".env" (
    echo ❌ .env not found
    exit /b 1
)

REM Load .env variables
for /f "usebackq tokens=1,* delims==" %%A in (".env") do (
    set "VAR=%%A"
    set "VAL=%%B"
    if not "!VAR!"=="" (
        set "!VAR!=!VAL!"
    )
)

REM Require creds
if "%DOCKERHUB_USERNAME%"=="" (
    echo ❌ DOCKERHUB_USERNAME not set in .env
    exit /b 1
)
if "%DOCKERHUB_PASSWORD%"=="" (
    echo ❌ DOCKERHUB_PASSWORD not set in .env
    exit /b 1
)

REM Defaults
if "%AGENT_SCALE%"=="" (
    set "AGENT_SCALE=4"
)
set "COMPOSE_FILE=docker-compose.yaml"

REM Login
echo %DOCKERHUB_PASSWORD% | docker login -u %DOCKERHUB_USERNAME% --password-stdin
if errorlevel 1 exit /b 1

REM Bring stack up & scale agents
docker compose -f "%COMPOSE_FILE%" up -d --scale agent=%AGENT_SCALE%
if errorlevel 1 exit /b 1

REM Logout
docker logout >nul 2>&1

REM Success
echo ✅ SuprVision stack started successfully.

endlocal
