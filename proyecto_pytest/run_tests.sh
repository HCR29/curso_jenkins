#!/bin/bash

echo "Activando entorno virtual"

# Crear entorno virtual si no existe
if [ ! -d "venv" ]; then
    echo "Entorno virtual no encontrado, creándolo..."
    python -m venv venv
fi

# Activar entorno virtual según el sistema operativo
if [ -f "venv/bin/activate" ]; then
    # Linux/MacOS
    source venv/bin/activate
elif [ -f "venv/Scripts/activate" ]; then
    # Windows
    source venv/Scripts/activate
else
    echo "Error: No se pudo encontrar el script de activación"
    exit 1
fi


echo "Entorno virtual activado correctamente"
#Verificar si pip esta instalando correctamente

echo "instalando dependencias"
pip install --upgrade pip --break-system-packages
pip install -r requirements.txt --break-system-packages

mkdir -p reports
# Ejecutar pruebas
echo "Ejecutano pruebas con pytest"

venv/bin/python -m pytest tests/ --junitxml=reports/test-results.xml --html=reports/report.html --self-contained-html

echo "pruebas finalizadas resultados en reports"
