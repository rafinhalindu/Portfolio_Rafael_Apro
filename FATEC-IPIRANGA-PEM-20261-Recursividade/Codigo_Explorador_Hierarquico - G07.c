/* 
============================================================
		    EXPLORADOR HIERÁRQUICO - G07 - 2026 1
		      Programação Estruturada Modular
============================================================
Integrantes:
- Gabriel Araújo da Silva
- Isabela Rocha do Nascimento
- Rafael Apro Rodrigues
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct No {
	char nome[64];
	long tamanho;
	long total;
	int num_filhos;
	struct No *filhos[16];
} No;

No *criar_no(char *nome, long tamanho) {
	No *n = calloc(1, sizeof(No));
	strcpy(n->nome, nome);
	n->tamanho = tamanho;
	return n;
}

void add_filho(No *pai, No *filho) {
	pai->filhos[pai->num_filhos++] = filho;
}

long calcular_total(No *no) {
	no->total = no->tamanho;
	for (int i = 0; i < no->num_filhos; i++)
		no->total += calcular_total(no->filhos[i]);
	return no->total;
}

void mostrar(No *no, int nivel, long limite, int profundidade) {
	for (int i = 0; i < nivel; i++) printf("    ");
	printf("[%s] proprio=%ldGB | total=%ldGB", no->nome, no->tamanho, no->total);
	if (no->total > limite) printf("  <<< LIMITE EXCEDIDO >>>");
	printf("\n");

	if (profundidade == -1 || profundidade > 0) {
		for (int i = 0; i < no->num_filhos; i++)
			mostrar(no->filhos[i], nivel + 1, limite,
			        profundidade == -1 ? -1 : profundidade - 1);
	}
}

void liberar(No *no) {
	for (int i = 0; i < no->num_filhos; i++)
		liberar(no->filhos[i]);
	free(no);
}

int main(void) {

	int limite;
	printf("Limite de gigabytes\n");
	printf("Digite o valor desejado (GB): ");
	scanf("%d", &limite);

	while (limite < 0) {
		printf("Valor invalido! Ele nao pode ser negativo. Digite novamente: ");
		scanf("%d", &limite);
	}
	
	int profundidade;
	printf("\nProfundidade de varedura\n(-1 exibe tudo, 0 apenas as pastas raiz, 1 mostra apenas as pastas pai e filhos)\n");
	printf("Digite o valor desejado: ");
	scanf("%d", &profundidade);

	while (profundidade != -1 && profundidade != 0 && profundidade != 1) {
		printf("Valor invalido! Digite apenas -1, 0 ou 1: ");
		scanf("%d", &profundidade);
	}


	No *empresa  = criar_no("empresa",   5);
	No *dados    = criar_no("dados",    20);
	No *vendas   = criar_no("vendas",   80);
	No *sistemas = criar_no("sistemas", 15);

	add_filho(vendas,   criar_no("q1",          30));
	add_filho(vendas,   criar_no("q2",          25));
	add_filho(vendas,   criar_no("q3",         350));
	add_filho(dados,    vendas);
	add_filho(dados,    criar_no("rh",          50));
	add_filho(dados,    criar_no("financas",   200));
	add_filho(sistemas, criar_no("servidores", 310));
	add_filho(sistemas, criar_no("apps",        90));
	add_filho(empresa,  dados);
	add_filho(empresa,  sistemas);
	add_filho(empresa,  criar_no("backup",     300));

	printf("\n--- Sistema ---\n");


	calcular_total(empresa);
	mostrar(empresa, 0, limite, profundidade);
	liberar(empresa);

	return 0;
}