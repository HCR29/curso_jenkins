#!/bin/bash
echo "ingresando al proyecto"
cd proyect:pytest

echo "activando un entorno virtual"
source venv/bin/activate

echo "instalando dependencias"
pip install -r requirements.txt

echo "Ejecutano pruebas con pytest"
pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "pruebas finalizadas resultados en reports"
