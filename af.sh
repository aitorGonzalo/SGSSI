function verFrecuencias()
{

result=$(cat "$archivo" | tr -cd '[:alpha:]' | grep -o . | sort | uniq -c | sort -k1,1nr)


echo -e "     Letra\t|   Apariciones"
echo "---------------------------------"
echo "$result" | awk '{print "|\t"$2"\t|\t"$1"\t|"}'
echo "---------------------------------"
}

function cambiarLetras()
{
    read -p "(MAYUSCULA)Letra a reemplazar: " letra1
    read -p "(minuscula)Letra de reemplazo: " letra2
    
    cat "$archivo" | tr "$letra1" "$letra2" > ".$archivo.tmp"
}

function verResultado()
{
    cat ".$archivo.tmp"
}

function restaurarOriginal()
{
    cat "$archivo" > ".$archivo.tmp"
}

function guardarResultado()
{
    cat ".$archivo.tmp" > "$archivo"
}

function salir()
{
    echo "Saliendo..."
    exit 0
}

###MAIN###

if [ $# -ne 1 ]; then
  echo "Uso: $0 archivo_de_texto"
  exit 1
fi

archivo="$1"


if [ ! -f "$archivo" ]; then
  echo "El archivo $archivo no existe."
  exit 1
fi

# Muestra el menu de opciones
opcion=0
while test $opcion -ne 6
do
        #Menu
        echo -e "\n==== MENU DE OPCIONES===="
        echo -e "01) Analizar la frecuencia de letras"
        echo -e "02) Cambiar letra"
        echo -e "03) Ver resultado"
        echo -e "04) Restaurar original"
        echo -e "05) Guardar resultado"
        echo -e "00) Salir\n"
        read -p "Elige una opcion: " opcion
        echo ""
                case $opcion in
                1) verFrecuencias;;
                2) cambiarLetras;;
                3) verResultado;;
                4) restaurarOriginal;;
                5) guardarResultado;;
                *) salir;;
                esac
done


