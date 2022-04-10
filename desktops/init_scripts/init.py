#!/usr/pkg/bin/python3.10
"""
init.py creates .config/infinity dir for desktop
"""
from pathlib import Path
import os
import sys

CONFIG_PATH = f"{Path.home()}/.config/infinity"

if not Path(CONFIG_PATH).exists():
    try:
        os.makedirs(CONFIG_PATH)
    except PermissionError as e:
        print(f"Could not create {CONFIG_PATH}: {e}")
        sys.exit(1)
