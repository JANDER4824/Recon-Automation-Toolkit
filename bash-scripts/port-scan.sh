#!/bin/bash
# port-scan.sh
# Descripción: Wrapper para Nmap con perfiles de escaneo rápido y completo, configurable por YAML.
# Autor: JANDER4824
# Dependencias: nmap, yq, date, mkdir

set -e

for cmd in nmap yq date mkdir; do
    command -v $cmd >/dev/null 2>&1 || { echo "Error: $cmd no está instalado."; exit 1; }
done

usage() {
    echo "Uso: $0 -t <objetivo> -p <perfil> [-o <carpeta_salida>]"
    echo "Perfil: quick | full"
}

while getopts ":t:p:o:" opt; do
  case $opt in
    t) TARGET="$OPTARG";;
    p) PROFILE="$OPTARG";;
    o) OUTPUT="$OPTARG";;
    *) usage; exit 1;;
  esac
done

[ -z "$TARGET" ] && { usage; exit 1; }
[ -z "$PROFILE" ] && { usage; exit 1; }
TIMESTAMP=$(date '+%Y%m%d-%H%M%S')
OUTDIR="${OUTPUT:-outputs/$TIMESTAMP}"
mkdir -p "$OUTDIR"

CONFIG="configs/nmap-$PROFILE.yaml"
[ ! -f "$CONFIG" ] && { echo "Config $CONFIG no encontrada."; exit 1; }

ARGS=$(yq '.nmap_args' "$CONFIG")
echo "[*] Ejecutando nmap $ARGS $TARGET"
nmap $ARGS "$TARGET" -oN "$OUTDIR/nmap-$PROFILE.txt" -oX "$OUTDIR/nmap-$PROFILE.xml"

echo "[+] Resultados guardados en $OUTDIR"