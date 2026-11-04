#!/usr/bin/env python3
"""Compose startup: prepare the complete demo without external CSV/XLSX files."""
import json
import sys
from pathlib import Path

sys.path.insert(0,str(Path(__file__).resolve().parents[2]/'backend'))
from app.repositories.database import engine, Repository
from school_demo import prepare_demo

if __name__=='__main__':
    with engine.begin() as connection:
        result=prepare_demo(Repository(connection))
        checks=Path(__file__).resolve().parents[1]/'postgres/tests/foundation_checks.sql'
        connection.exec_driver_sql(checks.read_text(encoding='utf-8'))
    print(json.dumps(result))
