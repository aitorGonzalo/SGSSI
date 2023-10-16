#!/bin/bash


while getopts "d:h:" opt; do
  case $opt in
    d) carpeta="$OPTARG";;
    h) hash_md5="$OPTARG";;
    \?) echo "Uso incorrecto del script."
        echo "Uso: $0 -d <carpeta> -h <hash_md5>"
        exit 1;;
  esac
done


if [ -z "$carpeta" ] || [ -z "$hash_md5" ]; then
  echo "Faltan argumentos."
  echo "Uso: $0 -d <carpeta> -h <hash_md5>"
  exit 1
fi


if [ ! -d "$carpeta" ]; then
  echo "La carpeta '$carpeta' no existe."
  exit 1
fi


encontrado=false

for archivo in "$carpeta"/*; do
    # Calcular el hash MD5 del archivo actual
    hash_archivo=$(md5sum "$archivo" | awk '{print $1}')
    
    if [ "$hash_archivo" == "$hash_md5" ]; then
        echo "El hash MD5 $hash_md5 se encontró en el archivo: $archivo"
        encontrado=true
        break  
    fi
done

if [ "$encontrado" == "false" ]; then
    echo "El hash MD5 $hash_md5 no se encontró en ningún archivo de la carpeta."
fi
