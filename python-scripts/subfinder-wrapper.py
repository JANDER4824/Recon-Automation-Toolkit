#!/usr/bin/env python3
"""
subfinder-wrapper.py
Descripción: Wrapper para Subfinder, almacena subdominios encontrados en outputs/.
Autor: JANDER4824
Dependencias: python3, subprocess, subfinder, argparse, os, datetime
"""

import argparse
import os
import subprocess
from datetime import datetime
import shutil

def check_prereqs():
    for cmd in ["subfinder"]:
        if not shutil.which(cmd):
            print(f"Error: {cmd} no está instalado.")
            exit(1)

def main():
    parser = argparse.ArgumentParser(description='Wrapper para Subfinder.')
    parser.add_argument('-d', '--domain', required=True, help='Dominio objetivo')
    parser.add_argument('-o', '--output', default=None, help='Carpeta de salida')
    args = parser.parse_args()

    ts = datetime.now().strftime('%Y%m%d-%H%M%S')
    outdir = args.output or f"outputs/{ts}"
    os.makedirs(outdir, exist_ok=True)

    check_prereqs()
    results_path = os.path.join(outdir, "subfinder.txt")
    subprocess.run(["subfinder", "-d", args.domain, "-o", results_path])

    print(f"[+] Subdominios guardados en {results_path}")

if __name__ == "__main__":
    main()