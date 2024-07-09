cp ~/Downloads/ecommerce/dados_de_vendas.csv ~/Downloads/ecommerce/vendas
current_date=$(date +%Y%m%d)
cp ~/Downloads/ecommerce/vendas/dados_de_vendas.csv ~/Downloads/ecommerce/vendas/backup/dados-$current_date.csv
mv ~/Downloads/ecommerce/vendas/backup/dados-$current_date.csv ~/Downloads/ecommerce/vendas/backup/backup-dados-$current_date.csv
echo "Data do sistema operacional: $(date +%Y/%m/%d\ %H:%M)" > ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
echo "Data do primeiro registro de vendas:" >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
awk -F, 'NR==2 {print $5}' ~/Downloads/ecommerce/vendas/dados_de_vendas.csv >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
echo "Data do último registro de vendas:" >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
awk -F, 'END {print $5}' ~/Downloads/ecommerce/vendas/dados_de_vendas.csv >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
echo "Quantidade total de itens diferentes vendidos:" >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
awk -F, '{print $2}' ~/Downloads/ecommerce/vendas/dados_de_vendas.csv | sort | uniq -c | wc -l >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
echo "Primeiras 10 linhas do arquivo:" >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
head -n 11 ~/Downloads/ecommerce/vendas/backup/backup-dados-$current_date.csv >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
zip ~/Downloads/ecommerce/vendas/backup/backup-dados-$current_date.zip ~/Downloads/ecommerce/vendas/backup/backup-dados-$current_date.csv
rm ~/Downloads/ecommerce/vendas/backup/backup-dados-$current_date.csv
rm ~/Downloads/ecommerce/vendas/dados_de_vendas.csv

