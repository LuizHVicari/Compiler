This README.MD file is available in both Portuguese and English.

ENGLISH:

Compiler project developed for the compiler course. The project consists of a compiler that has a lexical analyzer and a parser (already developed) and a semantic analyzer and code generation (not yet developed). It works with the Small L language, developed by the teacher for this project.

To run the program, type the following commands in the terminal (in order):

```bash
flex lexic.lex
bison -d parser.y
gcc -c -o parser.o parser.tab.c
gcc -c -o main.o main.c
gcc -o main parser.o main.o
./main test.l
```

The commands generated the .c and .o files to run the compiler, in the last command, instead of test.l, you should put the name of the program you want to compile.

PORTUGUÊS:

Projeto de compilador desenvolvido para a disciplina de compiladores. O projeto consiste em um compilador que possui um analisador léxico e um analizador sintático (já desenvolvidos) e um analisador semântico e geração de código (ainda não desenvolvidos). Ele trabalha com a linguagem Small L, desenvolvida pelo professor para este projeto.

Para executar o programa, digite os seguintes comandos no terminal (em ordem):

```bash
flex lexic.lex
bison -d parser.y
gcc -c -o parser.o parser.tab.c
gcc -c -o main.o main.c
gcc -o main parser.o main.o
./main test.l
```

Os comandos geraram os arquivos .c e .o para executar o compilador, no último comando, em vez de test.l, deve ser colocado o nome do programa que deseja compilar.

