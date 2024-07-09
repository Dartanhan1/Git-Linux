relatorios_dir=~/Downloads/ecommerce/vendas/backup
relatorio_final=~/Downloads/ecommerce/vendas/backup/relatorio_final.txt
 Limpa o arquivo final de relatório antes de escrever
> $relatorio_fina
for relatorio in $relatorios_dir/relatorio_*.txt; do
    cat $relatorio >> $relatorio_final
    echo "" >> $relatorio_final  
done
echo "Relatório final criado com sucesso em $relatorio_final."
