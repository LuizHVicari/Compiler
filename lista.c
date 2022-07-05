#include "lista.h"

// cria a lista (inicialmente vazia)
lista* ini_lista(void){
    lista *list = malloc(sizeof(lista));
    // lista vazia (ainda não tem cabeça)
    list->head = NULL;

    return list;
}

// cria uma struct de atributos das palavras
variavel* new_var(char* lex_value, int value){
    variavel *var = malloc(sizeof(variavel));
    // define o próximo como nulo (fim da fila)
    var->next = NULL;
    // passa os valores das palvras para o nó da lista
    var->value = value;
    var->lex_value = lex_value;
    return var;
} 

int insert_node(lista* list, char* lex_value, int value){
    variavel *run;
    // se a lista for nula, a cabeça recebe o nó desejado
    if(list == NULL || list->head == NULL){
        list->head = new_var(lex_value, value);
        return 0;
    }
    else{
        run = list->head;
        // percorre a lista até encontrar o final
        while(run->next != NULL){
            // se o valor lexico armazenado no nó atual for igual ao buscado, define o valor no nó e sai da função
            if(strcmp(run->lex_value, lex_value) == 0){
                run->value = value;
                return 0;
            }
            // avança na lista
            run = run->next;
        }
        // se encontrar o valor no final da lista, insere o valor no nó
        if(strcmp(run->lex_value, lex_value) == 0){
            run->value = value;
            return 0;
        }
        // se não encontrar o valor na lista, cria um novo nó no final
        run->next = new_var(lex_value, value);
        return 0;
    }
}

// percorre a lista para retornar um valor
int var_value(lista* list, char* lex_value){
    variavel *run;
    // verifica se a lista existe e não é vazia e percorre-a
    if(!(list == NULL || list->head == NULL)){
        run = list->head;
        while(run != NULL){
            // se encontrar o nó, retorna o valor dele
            if(strcmp(run->lex_value, lex_value) == 0){
                return run->value;
            }
            run = run->next;
        }
    }
    return 0;
}

// função para limpar a lista da memória do computador
void clear_lista(lista* list){
    variavel *run;
    // se existir, percorre a lista, desmembrando os nós e limpando a memória
    if(list != NULL){
        while(!(list == NULL) && !(list->head == NULL)){
            run = list->head;
            list->head = list->head->next;
            free(run);
        }
        // limpa a lista
        free(list);
    }
}