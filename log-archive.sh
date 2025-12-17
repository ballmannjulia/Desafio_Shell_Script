#!/usr/bin/env bash

# ============================
# Log Archive Tool
# ============================

# Verifica se o usuário passou um argumento
if [ $# -ne 1 ]; then
  echo "Uso: $0 <diretorio-de-logs>"
  exit 1
fi

LOG_DIR="$1"

# Verifica se o diretório existe
if [ ! -d "$LOG_DIR" ]; then
  echo "Erro: '$LOG_DIR' não é um diretório válido."
  exit 1
fi

# Cria timestamp
TIMESTAMP=$(date "+%Y%m%d_%H%M%S")

# Diretório onde os arquivos serão salvos
ARCHIVE_DIR="./archives"
mkdir -p "$ARCHIVE_DIR"

# Nome do arquivo compactado
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"

# Cria o arquivo tar.gz
tar -czf "$ARCHIVE_NAME" -C "$LOG_DIR" .

# Move para a pasta de arquivos
mv "$ARCHIVE_NAME" "$ARCHIVE_DIR/"

# Registra no log
echo "$(date "+%Y-%m-%d %H:%M:%S") - Arquivado '$LOG_DIR' em $ARCHIVE_NAME" >> "$ARCHIVE_DIR/archive.log"

echo "✅ Arquivo criado com sucesso:"
echo "   $ARCHIVE_DIR/$ARCHIVE_NAME"

