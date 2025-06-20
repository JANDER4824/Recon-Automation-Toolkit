# Recon-Automation-Toolkit

Automatiza y documenta la fase de reconocimiento y rastreo en pruebas de penetración. Incluye scripts Bash y Python, módulos configurables y plantillas para generación de informes.

## Características

- Descubrimiento de red (ARP, ping sweep, masscan)
- Escaneo de puertos rápido y completo (Nmap)
- Enumeración de servicios (SMB, HTTP, FTP)
- Subdominios y screenshots automatizados (Subfinder, Selenium)
- Configuración modular y outputs ordenados

## Instalación y requisitos previos

Instala las dependencias principales:

```bash
# Dependencias de sistema
sudo apt update && sudo apt install -y arp-scan fping masscan nmap enum4linux yq python3 python3-pip curl
# Para Recon-ng y Subfinder
pip3 install recon-ng
GO111MODULE=on go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
# Para Selenium
pip3 install selenium
# Instala Chrome/Chromium y chromedriver
sudo apt install -y chromium-driver chromium-browser
```

## Ejemplo de uso

```bash
# Descubrir hosts en red interna
sudo bash bash-scripts/network-discovery.sh -i eth0 -r 192.168.1.0/24

# Escaneo de puertos crítico y completo
sudo bash bash-scripts/port-scan.sh -t 192.168.1.100 -p quick
sudo bash bash-scripts/port-scan.sh -t 192.168.1.100 -p full

# Enumerar servicios SMB
sudo bash bash-scripts/service-enum.sh -t 192.168.1.100 -s smb

# Subdominios y screenshots
python3 python-scripts/subfinder-wrapper.py -d ejemplo.com
python3 python-scripts/screenshot-taker.py -i outputs/<fecha>/subfinder.txt
```

## Extensión y contribución

- Añade scripts en las carpetas correspondientes.
- Sigue los encabezados y convenciones de los scripts existentes.
- Documenta tus cambios en `docs/USAGE.md` y `README.md`.
- Haz pull requests siguiendo las buenas prácticas de GitHub.

## Licencia

MIT License (ver LICENSE)

---