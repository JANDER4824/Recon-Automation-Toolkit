# USAGE.md

## Ejecución paso a paso

### 1. Ping sweep de la red interna

```bash
sudo bash bash-scripts/network-discovery.sh -i eth0 -r 192.168.1.0/24
```
- **Resultado:** archivos `arp-scan.txt`, `ping-sweep.txt`, `masscan.txt` en la carpeta de salida.

### 2. Enumerar puertos críticos en un host

```bash
sudo bash bash-scripts/port-scan.sh -t 192.168.1.100 -p quick
sudo bash bash-scripts/port-scan.sh -t 192.168.1.100 -p full
```
- **Resultado:** archivos de salida Nmap en la carpeta correspondiente.

### 3. Detectar subdominios y capturar capturas de pantalla

```bash
python3 python-scripts/subfinder-wrapper.py -d ejemplo.com
# Luego
python3 python-scripts/screenshot-taker.py -i outputs/<fecha>/subfinder.txt
```
- **Resultado:** subdominios en `subfinder.txt`, capturas PNG en `screenshots/`.

### 4. Integrar resultados en un informe

1. Junta los resultados de cada script en la carpeta de salida.
2. Usa herramientas como `cat`, `csvstack` o editores para combinar los datos en un solo informe.
3. (Opcional) Agrega tus propias plantillas de informe o scripts de generación.

---