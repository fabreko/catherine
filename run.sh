PAN='~/Downloads/data-integration/pan.sh'
mysql -u root -p -D catherine < db/catherine.sql
eval $PAN -file='kettle/dim_curso.ktr' -level=Basic
eval $PAN -file='kettle/dim_local.ktr' -level=Basic
mysql -u root -p -D catherine  --local-infile < dados/load_dim_tempo.sql
