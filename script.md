# Scripts para rodar o projeto de compilador

Para esse projeto, foi utilizado o WSL2 com a distribuição Ubuntu, para executar na mesma distribuição, utilize os comandos abaixo.
```
flex anlex.l
bison -d ansin.y
gcc -c -o lista.o lista.c
gcc -c -o ansin.o ansin.tab.c
gcc -c -o main.o main.c
gcc -o main lista.o ansin.o main.o
./main nome_do_arquivo.extensao
```

## Instalando Flex e Bison

Todo o projeto foi utilizando a linguagem C e as ferramentas Flex e Bison para facilitar os processos de análise.

Algumas distribuições podem vir com o lex ou bison instalados, caso a sua não consiga rodar o programa tente instalar ambos com (funciona no Ubuntu dentro do WSL2):
```
sudo apt-get update
sudo apt-get install flex
sudo apt-get install bison
```
Note que não é necessário executar a instalação de alguma das ferramentas caso ela já esteja instalada na sua máquina, nesse caso, execute apenas a instalação daquela que será necessária.
