PT: Projeto de compilador desenvolvido para a disciplina de compiladores. O projeto consiste em um compilador que possui um analisador léxico e um analizador sintático (já desenvolvidos) e um analisador semântico e geração de código (ainda não desenvolvidos). Ele trabalha com a linguagem Small L, desenvolvida pelo professor para este projeto.

EN: Compiler project developed for the compiler course. The project consists of a compiler that has a lexical analyzer and a parser (already developed) and a semantic analyzer and code generation (not yet developed). It works with the Small L language, developed by the teacher for this project.

Para executar o programa, digite os seguintes comandos no terminal (em ordem) / To run the program, type the following commands in the terminal (in order):
```bash
flex lexic.lex
bison -d parser.y
gcc -c -o parser.o parser.tab.c
gcc -c -o main.o main.c
gcc -o main parser.o main.o
./main test.l
```