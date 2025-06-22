#!/bin/bash

# Configuración
VENV_DIR="venv"
REPORTS_DIR="reports"
PYTHON_CMD="python3"

# Crear directorio de reports
mkdir -p "$REPORTS_DIR"

# Verificar Python
if ! command -v $PYTHON_CMD &> /dev/null; then
    echo "ERROR: Python3 no encontrado. Se requiere Python 3.6+ instalado."
    exit 1
fi

# Intentar crear entorno virtual con diferentes métodos
echo "Creando entorno virtual (método 1: venv)..."
if $PYTHON_CMD -m venv "$VENV_DIR" &> /dev/null; then
    echo "Entorno virtual creado con venv"
else
    echo "Método venv falló, probando con virtualenv..."
    $PYTHON_CMD -m pip install --user virtualenv || {
        echo "ERROR: No se pudo instalar virtualenv"
        exit 1
    }
    $PYTHON_CMD -m virtualenv "$VENV_DIR" || {
        echo "ERROR: Fallo al crear entorno virtual con virtualenv"
        exit 1
    }
fi

# Activación multiplataforma
if [ -f "$VENV_DIR/bin/activate" ]; then
    source "$VENV_DIR/bin/activate"
elif [ -f "$VENV_DIR/Scripts/activate" ]; then
    source "$VENV_DIR/Scripts/activate"
else
    echo "ERROR: Script de activación no encontrado"
    exit 1
fi

# Continuar con la ejecución normal
echo "Instalando dependencias..."
pip install -r requirements.txt || exit 1

echo "Ejecutando pruebas..."
pytest tests/ --junitxml="$REPORTS_DIR/results.xml" || exit 1

echo "Build exitoso"
exit 0