# Compiler

## Objetivos do Projeto

O projeto, proposto pela disciplina de Compiladores, tem como objetivo desenvolver um protótipo de compilador, criando um analisador léxico, um analisador sintático e geração de código simples para a linguagem small L. Devido ao tempo e desenvolvimento da disciplina (apenas um semestre letivo), a etapa de geração de código conta apenas com instruções para uma calculadora, soma, subtração, adicão e divisão.

As etapas de desenvolvimento do compilador são:

- [x] Analisador léxico
- [x] Analisador sintático
- [x] Analisador semântico e gerador de código intermediário simples

## Ferramentas Utilizadas no Projeto

- Para o desenvolvimento do analisador semântico, foi utilizada a ferramenta Flex;
- O desenvolvimento das outras etapas utilizou [Bison](https://www.gnu.org/software/bison/);

## Linguagem Small L

A linguagem na qual o projeto se baseia é a linguagem Small L, cuja gramatica é a seguinte:
```
<programa> ::= programa <identificador> ; <bloco>
<bloco> ::= var <declaracao> inicio <comandos> fim
<declaracao> ::= <nome_var> : <tipo> ; | <nome_var > : <tipo> ; <declaracao>
<nome_var> ::= <identificador> | <identificador> , <nome_var>
<tipo> ::= inteiro | real | booleano
<comandos> ::= <comando> | <comando> ; <comandos>
<comando> ::= <atribuicao> | <condicional> | <enquanto> | <leitura> | <escrita>
<atribuicao> ::= <identificador> := <expressão>
<condicional> ::= se <expressão> entao <comandos> | se <expressão> entao <comandos> senao <comandos>
<enquanto> ::= enquanto <expressao> faca <comandos>
<leitura> ::= leia ( <identificador> )
<escrita> ::= escreva ( <identificador> )
<expressao> ::= <simples> | <simples> <op_relacional> <simples>
<op_relacional> ::= <> | = | < | > | <= | >=
<simples> ::= <termo> <operador> <termo> | <termo>
<operador> ::= + | - | ou
<termo> ::= <fator> | <fator> <op> <fator>
<op> ::= * | div | e
<fator> ::= <identificador> | <numero> | (<expressao>) | verdadeiro | falso | nao <fator>
<identificador> ::= id
<numero> ::= num
```

Todos os simbolos no formato rodeados por maior e menos são variáveis, os demais são terminais

## Problemas

O compilador desenvolvido não consegue trabalhar com valores numéricos não atribuídos a uma variável, por exemplo:

### Não funciona:
```
x := x + 1
```

### Funciona:
```
y := 1
x := x + y
```

## Agradecimentos e Outras Soluções para o Projeto

Esse projeto é baseado no compilador dos colegas [João Henrique Pereira Machado](https://github.com/joaoHenriqueMachado) e [Daniel Gustavo Favero](https://github.com/danielg-favero). Ambos tem também um compilador desenvolvido em suas páginas.

Repositórios de colegas que também desenvolveram esse trabalho:

- [Daniel Favero](https://github.com/danielg-favero/compiladores)
- [João Henrique Machado](https://github.com/joaoHenriqueMachado/compiladores)
- [Patrick Catto](https://github.com/pcatto/compiladores)
- [Jeferson Souza](https://github.com/souzjfe/compilers-UTFPR)
- [Cinglair Capello](https://github.com/cinglair/Analisador_Sintatico)
- [Luiz Brumati](https://github.com/luiz1303/compilers)

Todos esses repositórios usam as mesmas ferramentas e apresentam soluções similares para o trabalho.

Também, eu desenvolvi um analisador sintático para a mesma linguagem utilizando Python, se quiser ver a resolução, é só clicar nesse [link](https://github.com/LuizHVicari/Lexical-Analyzer-Python).