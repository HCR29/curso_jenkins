#!/bin/bash

echo "activando un entorno virtual"
if [!"-d venv"]; then
	python3 -m venv venv
fi
source venv/bin/activate

#Avtivar entorno virtual correctamente
if[-f "venv/bin/avtivate"]; then
	source venv/bin/activate
elif[ -f "venv/Scripts/avtivate"]; then
	source venv/Scripts/activate
else
	echo "Error : no se pudo activar el entorno virtual"
	exit 1
fi

#Verificar si pip esta instalando correctamente

echo "instalando dependencias"
pip install --upgrade pip --break-system-packages
pip install -r requirements.txt --break-system-packages

mkdir -p reports
# Ejecutar pruebas
echo "Ejecutano pruebas con pytest"
venv/bin/python -m pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "pruebas finalizadas resultados en reports"
