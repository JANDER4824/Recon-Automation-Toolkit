#!/bin/bash
# service-enum.sh
# Descripción: Enumeración de servicios SMB, HTTP, FTP.
# Autor: JANDER4824
# Dependencias: nmap, enum4linux, curl, nmap scripts, date, mkdir

set -e

for cmd in nmap enum4linux curl date mkdir; do
    command -v $cmd >/dev/null 2>&1 || { echo "Error: $cmd no está instalado."; exit 1; }
done

usage() {
    echo "Uso: $0 -t <objetivo> -s <servicio> [-o <carpeta_salida>]"
    echo "Servicio: smb | http | ftp"
}

while getopts ":t:s:o:" opt; do
  case $opt in
    t) TARGET="$OPTARG";;
    s) SERVICE="$OPTARG";;
    o) OUTPUT="$OPTARG";;
    *) usage; exit 1;;
  esac
done

[ -z "$TARGET" ] && { usage; exit 1; }
[ -z "$SERVICE" ] && { usage; exit 1; }
TIMESTAMP=$(date '+%Y%m%d-%H%M%S')
OUTDIR="${OUTPUT:-outputs/$TIMESTAMP}"
mkdir -p "$OUTDIR"

case "$SERVICE" in
    smb)
        echo "[*] Enumerando SMB con enum4linux y nmap..."
        enum4linux -a "$TARGET" > "$OUTDIR/enum4linux.txt"
        nmap --script smb-enum-shares,smb-enum-users -p 445 "$TARGET" > "$OUTDIR/smb-nmap.txt"
        ;;
    http)
        echo "[*] Enumerando HTTP con nmap y curl..."
        nmap --script http-title,http-headers,http-enum -p 80,443 "$TARGET" > "$OUTDIR/http-nmap.txt"
        curl -I "http://$TARGET" > "$OUTDIR/http-headers.txt" 2>/dev/null || true
        curl -I "https://$TARGET" > "$OUTDIR/https-headers.txt" 2>/dev/null || true
        ;;
    ftp)
        echo "[*] Enumerando FTP con nmap..."
        nmap --script ftp-anon,ftp-bounce,ftp-syst -p 21 "$TARGET" > "$OUTDIR/ftp-nmap.txt"
        ;;
    *)
        echo "Servicio no soportado."; exit 1;;
esac

echo "[+] Resultados guardados en $OUTDIR"