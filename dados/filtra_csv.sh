for i in *csv; do
    # retira cabecalho
    # ignora linhas que nao interessam
    # remove caracters de formatacao dos numeros
    tail -n +13 $i |  
        awk 'BEGIN {FS="\t"; OFS="\t"}; { print $2, $11, $12 }' |  
        tr -d ,. |  
        awk 'BEGIN {FS="\t"; OFS="\t"}; (NR % 6 == 1) { nome = $1 }; (NR % 6 == 0){ print nome, $2 + $3 }' > ${i}_out;

    awk -f agrupa_estado.awk ${i}_out | sponge ${i}_out;
done;
