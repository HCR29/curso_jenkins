#!/bin/bash

echo "activando un entorno virtual"
if [!"-d venv"]; then
	python3 -m venv venv
fi
source venv/bin/activate

echo "instalando dependencias"
pip install --upgrade pip
pip install -r requirements.txt

echo "Ejecutano pruebas con pytest"
pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "pruebas finalizadas resultados en reports"
