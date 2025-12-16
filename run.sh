#!/bin/bash

# 1. Wykrywanie Architektury
ARCH=$(uname -m)
echo "--- Detekcja Sprzętu ---"
echo "Architektura systemu: $ARCH"

# Domyślne flagi
COMPOSE_FILES="-f docker-compose.yml"
# Domyślny obraz (Intel/AMD)
BASE_IMAGE="osrf/ros:humble-desktop"
# Domyślna platforma Dockera
DOCKER_PLATFORM="linux/amd64"

# Logika decyzyjna
if [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
    if [ -f /etc/nv_tegra_release ]; then
        echo " WYKRYTO: NVIDIA Jetson Xavier AGX (L4T)"
        BASE_IMAGE="dustynv/ros:humble-desktop-l4t-r35.4.1"
        COMPOSE_FILES="-f docker-compose.yml -f docker-compose.jetson.yml"
        DOCKER_PLATFORM="linux/arm64"
    else
        echo " WYKRYTO: Apple Silicon / Inny ARM64"
        echo "  Uruchamiam w trybie standardowym (bez GPU passthrough)."
        # Na Macu z procesorem M1/M2/M3 musimy użyć standardowego obrazu ROS, 
        # ale wskazać platformę arm64, żeby nie emulował Intela.
        BASE_IMAGE="osrf/ros:humble-desktop" 
        DOCKER_PLATFORM="linux/arm64"
    fi
else
    echo " WYKRYTO: Stacja Robocza (x86_64)"
fi

# 2. Generowanie .env
echo "Generowanie konfiguracji .env..."
cat > .env <<EOF
BASE_IMAGE=$BASE_IMAGE
ARCH=$ARCH
PLATFORM=$DOCKER_PLATFORM
EOF

# 3. Wykrywanie czy Docker Daemon działa
if ! docker info > /dev/null 2>&1; then
    echo ""
    echo " BŁĄD KRYTYCZNY: Docker nie jest uruchomiony!"
    exit 1
fi

# 4. Wykrywanie komendy
if docker compose version > /dev/null 2>&1; then
    CMD="docker compose"
elif command -v docker-compose > /dev/null 2>&1; then
    CMD="docker-compose"
else
    echo " BŁĄD: Brak docker compose."
    exit 1
fi

# 5. Uruchomienie
echo " Uruchamiam konfigurację: $COMPOSE_FILES dla platformy $DOCKER_PLATFORM"
export DISPLAY=${DISPLAY:-}

$CMD $COMPOSE_FILES up -d --build

echo ""
echo " Gotowe. Aby wejść do środka:"
echo "$CMD exec rover_dev bash"
