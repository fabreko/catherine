BEGIN {
    FS="\t";
    OFS="\t";
}
{
    if ($1 ~ /^(ACRE|ALAGOAS|AMAPA|AMAZONAS|BAHIA|CEARA|DISTRITO FEDERAL|ESPIRITO SANTO|GOIAS|MARANHAO|MATO GROSSO|MATO GROSSO DO SUL|MINAS GERAIS|PARA|PARAIBA|PARANA|PERNAMBUCO|PIAUI|RIO DE JANEIRO|RIO GRANDE DO NORTE|RIO GRANDE DO SUL|RONDONIA|RORAIMA|SANTA CATARINA|SAO PAULO|SERGIPE|TOCANTINS)$/) {
        estado=$1
    } else if (length(estado) !=0) {
        print estado, $0
    }
}