#!/usr/bin/env python3
"""
recon-ng-automator.py
Descripción: Automatiza módulos de Recon-ng (domain-info, subdomain-enum). Guarda resultados en outputs/.
Autor: JANDER4824
Dependencias: python3, subprocess, Recon-ng instalado, argparse, os, datetime
"""

import argparse
import os
import subprocess
from datetime import datetime

def check_prereqs():
    for cmd in ["recon-ng"]:
        if not shutil.which(cmd):
            print(f"Error: {cmd} no está instalado.")
            exit(1)

def run_recon(domain, modules, outdir):
    cmds = [
        f"workspaces select {domain}",
        f"modules load recon/domains-hosts/{mod}; run; back" for mod in modules
    ]
    batch = "\n".join(cmds) + "\nexit\n"
    subprocess.run(["recon-ng", "-m", "batch"], input=batch.encode())

def main():
    parser = argparse.ArgumentParser(description='Automatiza Recon-ng.')
    parser.add_argument('-d', '--domain', required=True, help='Dominio objetivo')
    parser.add_argument('-m', '--modules', nargs='+', default=['whois_pocs', 'certspotter', 'brute_hosts'], help='Módulos Recon-ng')
    parser.add_argument('-o', '--output', default=None, help='Carpeta de salida')
    args = parser.parse_args()

    ts = datetime.now().strftime('%Y%m%d-%H%M%S')
    outdir = args.output or f"outputs/{ts}"
    os.makedirs(outdir, exist_ok=True)

    check_prereqs()
    run_recon(args.domain, args.modules, outdir)

    print(f"[+] Resultados guardados en {outdir}")

if __name__ == "__main__":
    main()