#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// lista de variáveis
typedef struct lista lista; 
// struct para armazenar os atributos das palavras do código
typedef struct variavel variavel;

struct lista{
    variavel* head;
};

struct variavel{
    int value;
    char* lex_value;
    variavel* next;
};

// definição das funções no header
variavel* new_var(char* lex_value, int value);
lista* ini_lista(void);
int insert_node(lista* list, char* lex_value, int value);
int var_value(lista* list, char* lex_value);
void clear_lista(lista* list);