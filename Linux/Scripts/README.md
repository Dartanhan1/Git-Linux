# Script: processamento_de_vendas.sh

# Etapa 1:

`#!/bin/bash`

1. **Criação do Script**: Um script `processamento_de_vendas.sh` será criado no diretório `~/Downloads/ecommerce/`.
`touch ~/Downloads/ecommerce/processamento_de_vendas.sh`

2. **Diretório de Vendas**: Um diretório `vendas` será criado em `~/Downloads/ecommerce/` para armazenar os arquivos de vendas.
`mkdir -p ~/Downloads/ecommerce/vendas`

3. **Cópia dos Dados**: O arquivo `dados_de_vendas.csv` será copiado para o diretório `vendas`.
`cp ~/Downloads/ecommerce/dados_de_vendas.csv ~/Downloads/ecommerce/vendas`

# Etapa 2:

1. **Obter data atual, Criação de Backup**: Uma cópia dos dados será criada com a data atual no nome e movida para o diretório `backup`.
`current_date=$(date +%Y%m%d)`
`mkdir -p ~/Downloads/ecommerce/vendas/backup`
`cp ~/Downloads/ecommerce/vendas/dados_de_vendas.csv ~/Downloads/ecommerce/vendas/backup/dados-$current_date.csv`

- Renomear arquivo dentro do diretório backup.
`mv ~/Downloads/ecommerce/vendas/backup/dados-$current_date.csv ~/Downloads/ecommerce/vendas/backup/backup-dados-$current_date.csv`

2. **Geração de Relatório**: Um relatório contendo a data do sistema, a data do primeiro e último registro de vendas, a quantidade total de itens vendidos e as primeiras 10 linhas do arquivo será gerado.
``` bash
echo "Data do sistema operacional: $(date +%Y/%m/%d\ %H:%M)" > ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
echo "Data do primeiro registro de vendas:" >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
awk -F, 'NR==2 {print $5}' ~/Downloads/ecommerce/vendas/dados_de_vendas.csv >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
echo "Data do último registro de vendas:" >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
awk -F, 'END {print $5}' ~/Downloads/ecommerce/vendas/dados_de_vendas.csv >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
echo "Quantidade total de itens diferentes vendidos:" >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
awk -F, '{print $2}' ~/Downloads/ecommerce/vendas/dados_de_vendas.csv | sort | uniq -c | wc -l >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
echo "Primeiras 10 linhas do arquivo:" >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
head -n 11 ~/Downloads/ecommerce/vendas/backup/backup-dados-$current_date.csv >> ~/Downloads/ecommerce/vendas/backup/relatorio_$current_date.txt
```
3. **Compressão e Limpeza**: Os dados serão comprimidos em um arquivo .zip, e os arquivos .csv originais serão excluídos após o backup.
Comprimir arquivo .csv para .zip.
`zip ~/Downloads/ecommerce/vendas/backup/backup-dados-$current_date.zip ~/Downloads/ecommerce/vendas/backup/backup-dados-$current_date.csv`

- Apagar arquivos .csv.
`rm ~/Downloads/ecommerce/vendas/backup/backup-dados-$current_date.csv`
`rm ~/Downloads/ecommerce/vendas/dados_de_vendas.csv`

# Etapa 2 (continuação):

4. **Agendamento de Execução**: O script será agendado para ser executado às 15h27 de segunda a quinta-feira.
<!--Permite e Cria o agendamento de execução-->
`chmod +x ~/Downloads/ecommerce/processamento_de_vendas.sh
(crontab -l 2>/dev/null; echo "27 15 * * 1-4 ~/Downloads/ecommerce/processamento_de_vendas.sh") | crontab -`

- Exibe mensagem de conclusão.
`echo "Processamento de vendas concluído."`

# Script: consolidador_de_processamento_de_vendas.sh
# Etapa 3:

1. **Criação do Script de Consolidação**: Um script `consolidador_de_processamento_de_vendas.sh` será criado para consolidar os relatórios gerados.
- Criação e formação do script consolidador_de_processamento_de_vendas.sh.
`touch ~/Downloads/ecommerce/consolidador_de_processamento_de_vendas.sh` 

- Diretório onde os relatórios estão localizados.
`relatorios_dir=~/Downloads/ecommerce/vendas/backup`

- Nome do arquivo final de relatório.
`relatorio_final=~/Downloads/ecommerce/vendas/backup/relatorio_final.txt`

- Limpa o arquivo final de relatório antes de escrever.
`> $relatorio_final`

2. **Consolidação dos Relatórios**: Todos os relatórios individuais serão combinados em um único arquivo `relatorio_final.txt` no diretório `vendas/backup`.
- Percorre todos os arquivos de relatório no diretório de relatórios.
```bash
for relatorio in $relatorios_dir/relatorio_*.txt; do
    # Adiciona o conteúdo do relatório ao relatório final
    cat $relatorio >> $relatorio_final
    echo "" >> $relatorio_final  # Adiciona uma linha em branco entre os relatórios
done

echo "Relatório final criado com sucesso em $relatorio_final." 
```

# Etapa 3 (continuação):

3. **Ativação do Consolidador**: O script de consolidação será ativado para consolidar automaticamente os relatórios.
Ativar e inicializar o script consolidador__de_processamento_de_vendas.sh.
```bash
chmod +x ~/Downloads/ecommerce/consolidador_de_processamento_de_vendas.sh 
./consolidador_de_processamento_de_vendas.sh (para ativar o consolidador de sistema)
```
