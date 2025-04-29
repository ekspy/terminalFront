#!/bin/bash

# Código de cores para estilo
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
SC='\033[0m'

display_menu() {
    clear
    echo -e "${BLUE}=== Frontend de Comandos ===${SC}"
    echo -e "${YELLOW}Comandos Disponíveis:${SC}"
    echo "1. man     - Mostra o manual"
    echo "2. ls      - Lista os diretórios"
    echo "3. pwd     - Printa o diretório corrente"
    echo "4. mkdir   - Cria o diretório"
    echo "5. cd      - Muda o diretório"
    echo "6. cp      - Copiar arquivo/diretório"
    echo "7. mv      - Mover arquivo/diretório"
    echo "8. rm      - Remover arquivo/diretório"
    echo "9. rmdir   - Remover diretório(s) vazios"
    echo "10. more   - Mostrar conteúdo do arquivo página por página"
    echo "11. cat    - Concatenar e mostrar arquivos"
    echo "12. tail   - Mostrar as últimas linhas do arquivo"
    echo "13. echo   - Printar uma string"
    echo "14. whoami - Mostrar o usuário corrente"
    echo "15. ps     - Mostrar o status do processo"
    echo "16. grep   - Procurar por padrões"
    echo "17. wc     - Contar palavras e caracteres"
    echo "18. SAIR"
    echo -e "${BLUE}========================${SC}"
}

executar_comando() {
    local cmd=$1
    shift
    local args="$@"

    case $cmd in
        "man")
            if [ -z "$args" ]; then
                echo -e "${RED}Erro: Necessário incluir nome do comando${SC}"
                return 1
            fi
            $cmd $args
            ;;
        "ls")
            $cmd $args
            ;;
        "pwd")
            $cmd
            ;;
        "mkdir")
            if [ -z "$args" ]; then
                echo -e "${RED}Erro: Necessário incluir nome do diretório${SC}"
                return 1
            fi
            $cmd $args
            ;;
        "cd")
            if [ -z "$args" ]; then
                $cmd ~
            else
                $cmd "$args" || echo -e "${RED}Erro: diretório não encontrado${SC}"
            fi
            ;;
        "cp")
            if [ $# -lt 2 ]; then
                echo -e "${RED}Erro: Necessário incluir origem e destino${SC}"
                return 1
            fi
            $cmd $args
            ;;
        "mv")
            if [ $# -lt 2 ]; then
                echo -e "${RED}Erro: Necessário incluir origem e destino${SC}"
                return 1
            fi
            $cmd $args
            ;;
        "rm")
            if [ -z "$args" ]; then
                echo -e "${RED}Erro: requer nome do arquivo/diretório${SC}"
                return 1
            fi
            $cmd $args
            ;;
        "rmdir")
            if [ -z "$args" ]; then
                echo -e "${RED}Erro: requer nome do diretório${SC}"
                return 1
            fi
            $cmd $args
            ;;
        "more"|"cat"|"tail")
            if [ -z "$args" ]; then
                echo -e "${RED}Erro: $cmd requer nome do arquivo${SC}"
                return 1
            fi
            $cmd $args
            ;;
        "echo")
            $cmd "$args"
            ;;
        "whoami")
            $cmd
            ;;
        "ps")
            $cmd $args
            ;;
        "grep")
            if [ -z "$args" ]; then
                echo -e "${RED}Erro: Necessário incluir padrão${SC}"
                return 1
            fi
            $cmd $args
            ;;
        "wc")
            if [ -z "$args" ]; then
                echo -e "${RED}Erro: Necessário incluir arquivo${SC}"
                return 1
            fi
            $cmd $args
            ;;
    esac
}

while true; do
    display_menu
    echo -e "${GREEN}Selecione uma opção (1-18):${SC}"
    read option

    case $option in
        1)
            echo -e "${YELLOW}Digite o nome do comando para o man${SC}"
            read args
            executar_comando "man" "$args"
            ;;
        2)
            echo -e "${YELLOW}Digite as opções para ls caso queira:${SC}"
            read args
            executar_comando "ls" "$args"
            ;;
        3)
            executar_comando "pwd"
            ;;
        4)
            echo -e "${YELLOW}Digite o nome do diretório:${SC}"
            read args
            executar_comando "mkdir" "$args"
            ;;
        5)
            echo -e "${YELLOW}Digite o caminho do diretório (ou pressione enter para usar ~):${SC}"
            read args
            executar_comando "cd" "$args"
            ;;
        6)
            echo -e "${YELLOW}Digite a origem e o destino:${SC}"
            read args
            executar_comando "cp" $args
            ;;
        7)
            echo -e "${YELLOW}Digite a origem e o destino:${SC}"
            read args
            executar_comando "mv" $args
            ;;
        8)
            echo -e "${YELLOW}Digite o(s) nome(s) do(s) arquivo(s)/diretório(s):${SC}"
            read args
            executar_comando "rm" "$args"
            ;;
        9)
            echo -e "${YELLOW}Digite o(s) nome(s) do(s) diretório(s):${SC}"
            read args
            executar_comando "rmdir" "$args"
            ;;
        10)
            echo -e "${YELLOW}Digite o nome do arquivo:${SC}"
            read args
            executar_comando "more" "$args"
            ;;
        11)
            echo -e "${YELLOW}Digite o(s) nome(s) do(s) arquivo(s):${SC}"
            read args
            executar_comando "cat" "$args"
            ;;
        12)
            echo -e "${YELLOW}Digite o nome do arquivo:${SC}"
            read args
            executar_comando "tail" "$args"
            ;;
        13)
            echo -e "${YELLOW}Digite para fazer o echo:${SC}"
            read args
            executar_comando "echo" "$args"
            ;;
        14)
            executar_comando "whoami"
            ;;
        15)
            echo -e "${YELLOW}Digite as opções caso queira:${SC}"
            read args
            executar_comando "ps" "$args"
            ;;
        16)
            echo -e "${YELLOW}Digite o padrão e o(s) arquivo(s):${SC}"
            read args
            executar_comando "grep" "$args"
            ;;
        17)
            echo -e "${YELLOW}Digite o nome do arquivo:${SC}"
            read args
            executar_comando "wc" "$args"
            ;;
        18)
            echo -e "${GREEN}Saindo...${SC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Opção inválida!${SC}"
            ;;
    esac
    
    echo -e "\n${BLUE}Pressione Enter para continuar...${SC}"
    read
done
