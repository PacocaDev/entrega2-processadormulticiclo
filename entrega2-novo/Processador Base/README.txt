Defina o bloco "mips" como base.

O arquivo "inst.mif" contém instruções de teste para verificar o funcionamento correto do processador da forma que está entregue a vocês.
Após a execução, é esperado o conteúdo do registrador 0 ser 0x000011, 1 ser 0x000002 e 2 ser 0x000003.

O funcionamento dos blocos de memória é tal a garantir a resposta em apenas um ciclo de clock e que seja endereçável por byte. Assim, é necessário um inicializador para o correto funcionamento. Durante esta inicialização, o clock é acelerado a fim de realizar esta tarefa de forma rápida.

Para o correto funcionamento na sua FPGA, utilize o MegaWizard para criar os blocos mem8 e ram_initializer. (Tutoriais anexos)

Lembrem-se de completar o código com já feito e entregue na primeira entrega.

Em caso de dúvidas de como montar o projeto no Quartus, não hesitem em entrar em contato comigo por email: luizhenrique@dcc.ufmg.br