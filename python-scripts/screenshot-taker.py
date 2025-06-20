#!/usr/bin/env python3
"""
screenshot-taker.py
Descripción: Captura pantallas web de una lista de URLs usando Selenium.
Autor: JANDER4824
Dependencias: python3, selenium, argparse, os, datetime, chromedriver
"""

import argparse
import os
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from datetime import datetime

def main():
    parser = argparse.ArgumentParser(description='Captura de screenshots web.')
    parser.add_argument('-i', '--input', required=True, help='Archivo con URLs (uno por línea)')
    parser.add_argument('-o', '--output', default=None, help='Carpeta de salida')
    args = parser.parse_args()

    ts = datetime.now().strftime('%Y%m%d-%H%M%S')
    outdir = args.output or f"outputs/{ts}/screenshots"
    os.makedirs(outdir, exist_ok=True)

    options = Options()
    options.headless = True
    driver = webdriver.Chrome(options=options)

    with open(args.input) as f:
        for idx, url in enumerate(f):
            url = url.strip()
            if not url: continue
            try:
                driver.get(url)
                fname = os.path.join(outdir, f"screenshot_{idx+1}.png")
                driver.save_screenshot(fname)
                print(f"[+] Capturado {fname}")
            except Exception as e:
                print(f"[-] Falló {url}: {e}")

    driver.quit()

if __name__ == "__main__":
    main()