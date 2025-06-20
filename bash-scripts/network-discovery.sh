#!/bin/bash
# network-discovery.sh
# Descripción: Escaneo de red LAN usando ARP, ping sweep y masscan para descubrir hosts activos.
# Autor: JANDER4824
# Dependencias: arp-scan, fping, masscan, date, mkdir

set -e

# Comprobación de prerrequisitos
for cmd in arp-scan fping masscan date mkdir; do
    command -v $cmd >/dev/null 2>&1 || { echo "Error: $cmd no está instalado."; exit 1; }
done

usage() {
    echo "Uso: $0 -i <interfaz> -r <rango_red> [-o <carpeta_salida>]"
    echo "Ejemplo: $0 -i eth0 -r 192.168.1.0/24"
}

# Parámetros CLI
while getopts ":i:r:o:" opt; do
  case $opt in
    i) IFACE="$OPTARG";;
    r) RANGE="$OPTARG";;
    o) OUTPUT="$OPTARG";;
    *) usage; exit 1;;
  esac
done

[ -z "$IFACE" ] && { usage; exit 1; }
[ -z "$RANGE" ] && { usage; exit 1; }
TIMESTAMP=$(date '+%Y%m%d-%H%M%S')
OUTDIR="${OUTPUT:-outputs/$TIMESTAMP}"
mkdir -p "$OUTDIR"

echo "[*] Escaneando red con arp-scan..."
arp-scan --interface="$IFACE" "$RANGE" > "$OUTDIR/arp-scan.txt"

echo "[*] Realizando ping sweep con fping..."
fping -a -g "$RANGE" 2>/dev/null > "$OUTDIR/ping-sweep.txt"

echo "[*] Escaneando hosts activos con masscan (puerto 80)..."
masscan -p80 "$RANGE" --rate 1000 > "$OUTDIR/masscan.txt"

echo "[+] Resultados guardados en $OUTDIR"