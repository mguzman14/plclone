FROM debian:12-slim

# Instalamos dependencias necesarias para compilar y ejecutar
RUN apt update && apt install -y \
    git \
    python3 \
    python3-pip \
    python3-venv \
    sudo \
    build-essential \
    pkg-config \
    libsqlite3-dev

# Clonamos OpenPLC
RUN git clone https://github.com/thiagoralves/OpenPLC_v3.git /OpenPLC_v3
WORKDIR /OpenPLC_v3

# Instalamos OpenPLC (usando el script oficial)
RUN ./install.sh linux

# Exponemos puertos de administración y Modbus
EXPOSE 8080 502

CMD ["./start_openplc.sh"]