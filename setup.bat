@echo off
title Social Autopilot - Setup
color 0A

echo.
echo  ============================================
echo   SOCIAL AUTOPILOT - ONE CLICK SETUP
echo  ============================================
echo.

:: Check Node.js
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is not installed.
    echo Please install it from https://nodejs.org and run this again.
    pause
    exit /b 1
)
echo [OK] Node.js found

:: Check Docker
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not installed.
    echo Please install Docker Desktop from https://docker.com and run this again.
    pause
    exit /b 1
)
echo [OK] Docker found

:: Check .env.local
if not exist ".env.local" (
    echo.
    echo [SETUP] Creating .env.local from template...
    copy .env.example .env.local
    echo.
    echo  ============================================
    echo   ACTION REQUIRED
    echo  ============================================
    echo.
    echo  Please open .env.local in Notepad and fill in:
    echo.
    echo  1. GROQ_API_KEY      - Get free at console.groq.com
    echo  2. AYRSHARE_API_KEY  - Get free at app.ayrshare.com
    echo  3. TELEGRAM_BOT_TOKEN - Get from @BotFather on Telegram
    echo  4. IMGBB_API_KEY     - Get free at api.imgbb.com
    echo.
    echo  After filling in your keys, run setup.bat again.
    echo.
    notepad .env.local
    pause
    exit /b 0
)
echo [OK] .env.local found

:: Start Docker Desktop if not running
echo.
echo [SETUP] Starting Docker...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo Docker Desktop is not running. Please start it manually and press any key...
    pause
)

:: Start containers
echo [SETUP] Starting database containers...
docker compose up -d
if %errorlevel% neq 0 (
    echo [ERROR] Failed to start Docker containers.
    echo Make sure Docker Desktop is running and try again.
    pause
    exit /b 1
)
echo [OK] Database running

:: Install dependencies
echo.
echo [SETUP] Installing dependencies (this may take a minute)...
call npm install --silent
if %errorlevel% neq 0 (
    echo [ERROR] npm install failed.
    pause
    exit /b 1
)
echo [OK] Dependencies installed

:: Run database migration
echo.
echo [SETUP] Setting up database...
timeout /t 5 /nobreak >nul
call npx prisma migrate deploy >nul 2>&1
if %errorlevel% neq 0 (
    call npx prisma migrate dev --name init
)
echo [OK] Database ready

:: Done
echo.
echo  ============================================
echo   SETUP COMPLETE!
echo  ============================================
echo.
echo  Starting Social Autopilot...
echo.
echo  Web Dashboard: http://localhost:3000
echo  Telegram Bot:  Running in background
echo.
echo  Press Ctrl+C to stop
echo.

:: Start both app and bot
call npm run dev:all
