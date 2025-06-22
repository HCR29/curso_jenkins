#!/bin/bash

# Configuración
VENV_DIR="venv"
REPORTS_DIR="reports"

# 1. Verificar Python
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python3 no encontrado. Instale con:"
    echo "sudo apt-get update && sudo apt-get install -y python3 python3-venv"
    exit 1
fi

# 2. Crear directorio de reports
mkdir -p "$REPORTS_DIR"

# 3. Crear y activar entorno virtual
echo "Creando entorno virtual..."
python3 -m venv "$VENV_DIR" || {
    echo "ERROR: Fallo al crear venv. Soluciones:"
    echo "1. Instale python3-venv: sudo apt-get install python3-venv"
    echo "2. Use: python3 -m pip install virtualenv && python3 -m virtualenv $VENV_DIR"
    exit 1
}

# 4. Activación multiplataforma
if [ -f "$VENV_DIR/bin/activate" ]; then
    source "$VENV_DIR/bin/activate"
elif [ -f "$VENV_DIR/Scripts/activate" ]; then
    source "$VENV_DIR/Scripts/activate"
else
    echo "ERROR: Script de activación no encontrado en:"
    echo "- $VENV_DIR/bin/activate"
    echo "- $VENV_DIR/Scripts/activate"
    exit 1
fi

# 5. Instalar dependencias y ejecutar pruebas
echo "Instalando dependencias..."
pip install -r requirements.txt || exit 1

echo "Ejecutando pruebas..."
pytest tests/ --junitxml="$REPORTS_DIR/results.xml" || exit 1

echo "Proceso completado exitosamente"
exit 0