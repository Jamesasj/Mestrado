#include<stdio.h>
#include<stdlib.h>
#include<string.h>
//#include<math.h>
#define LINHAS 4955
#define COLUNAS 5171

struct docData{
    int docId, featureId, valor;
    char classe[14];
}typedef Documento;

Documento **obterMatrix(char fileNameMTX[], char fileNameClass[] ){
	FILE *fp1, *fp2;
	char *pLinha1, *pLinha2, linha1[50], linha2[50], classe[13], *classeTreino;
	int linhas, colunas, valor, i, j, lin, col;
	int k = 3, acertos = 0;
	int tamTreinamento = LINHAS * 80 / 100;  //3964 (80%)
	int tamTestes = LINHAS - tamTreinamento; // 991 (20%)
	
	fp1 = fopen(fileNameMTX, "r");
	fp2 = fopen(fileNameClass, "r");    
	pLinha1 = fgets(linha1, 50, fp1);
	pLinha2 = fgets(linha2, 50, fp2);
	
	fscanf(fp1, "%d %d %d", &linhas, &colunas, &valor);
	pLinha2 = fgets(classe, 14, fp2);
	
	Documento **matriz = (Documento**)malloc(linhas * sizeof(Documento*)); //Aloca um Vetor de Ponteiros
	
	for (i = 0; i < linhas; i++){ //Percorre as linhas do Vetor de Ponteiros
		matriz[i] = (Documento*) malloc(colunas * sizeof(Documento)); //Aloca um Vetor de Inteiros para cada posição do Vetor de Ponteiros.
	
		for (j = 0; j < colunas; j++){
			matriz[i][j].docId = 0;
			matriz[i][j].featureId = 0;
			matriz[i][j].valor = 0; 
			strcpy(matriz[i][j].classe, "noClass");
		}
	}
	
	i = 1;
	fscanf(fp1, "%d %d %d", &lin, &col, &valor);
	
	// Cria a matriz associando a linha do .mtx com a devida classe
	while(!feof(fp1)){
		if(i == lin){
			matriz[lin-1][col-1].docId = lin;
			matriz[lin-1][col-1].featureId = col;
			matriz[lin-1][col-1].valor = valor;
			strcpy(matriz[lin-1][col-1].classe, classe);
		}
		else{
			pLinha2 = fgets(classe, 13, fp2);
			matriz[lin-1][col-1].docId = lin;
			matriz[lin-1][col-1].featureId = col;            
			matriz[lin-1][col-1].valor = valor;
			strcpy(matriz[lin-1][col-1].classe, classe);            
			i++;
		}
		fscanf(fp1, "%d %d %d", &lin, &col, &valor);
	}
	
	return matriz;
}


int main(int argc, char const *argv[])
{
    char fileNameMTX[] = "dataset/marco_civil.mtx";
    char fileNameClass[] = "dataset/mc1.class";

    Documento **matriz = obterMatrix(fileNameMTX, fileNameClass);
	
    free(matriz);
    //free(treina);
    printf("Execucao bem sucedida.");
    //printf("\n\n\tForam obtidos %d acertos em %d testes realizados.\n\n", acertos, tamTestes);
    return 0;
}
