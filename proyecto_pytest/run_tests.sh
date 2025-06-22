#!/bin/bash

# Configuración
REPORTS_DIR="reports"
mkdir -p "$REPORTS_DIR"

# Usar pip con --break-system-packages (SOLO PARA PRUEBAS)
python3 -m pip install --break-system-packages virtualenv
python3 -m virtualenv venv
source venv/bin/activate

# Continuar con el proceso normal
pip install -r requirements.txt
pytest tests/ --junitxml="$REPORTS_DIR/results.xml"
exit 0