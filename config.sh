#!/bin/sh

# == O quê é essa primeira linha? ==
# Quando colomos "#!/bin/sh", estamos indicando para o sistema operacional que o interpretador que deverá ser utilizado para executar este programa é o disponível no diretório /bin/sh." Este interpretador faz parte da distribuição UNIX (Linux e MacOS) padrão e sua localização também é padronizada.

# =============================
# = Checking user permissions =
# =============================

# == EXPLICAÇÃO: O que esse trecho de código faz? ==
# O trecho abaixo verificará com qual usuário o programa será executado. Caso o usuário em questão não possua permissões de root, será retornada uma mensagem ao usuário e a execução do programa será cancelada

if [ $(id -u) != 0 ]
then
    echo "Para funcionar corretamente, este programa precisa ser executado com permissões de super usuário (sudo). Por gentileza, execute o comando de conforme abaixo:"
    echo "sudo ./config.sh"
    exit
fi

# == DETALHES ==
# O comando "id -u" retorna o ID do usuário e apenas o usuário root (também conhecido como "sudo", "super administrador" ou "super usuário") possui o ID igual a 0 (zero).
# O comando "echo" exibe na tela do usuário a informação disposta logo após sua chamada.
# O comando "exit" cancela a execução do código no seu ponto atual (o que foi executado antes dele, continua válido).
#
# Alguns links para vocês estudarem sobre como trabalhar com IFs em Shell Scritp (todos em inglês):
# https://linuxacademy.com/blog/linux/conditions-in-bash-scripting-if-statements/
# http://codewiki.wikidot.com/shell-script:if-else
# https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php

# =================================== 
# = User validation - .profile file =
# ===================================

# == EXPLICAÇÃO: O que esse trecho de código faz? ==
# O trecho abaixo informará ao usuário o que será feito em seu computador e perguntará se ele deseja continuar. Sempre que um programa for alterar configurações atuais, é de extrema importância que essa pergunta e o backup dos arquivos atuais sejam feitos."

echo "Olá. Este programa mudará a configuração atual do seu arquivo ~/.profile, que é o arquivo responsável pela configuração do seu terminal. Caso você já use uma versão customizada do seu terminal, recomendo que você cancele esta instalação e leia o arquivo README.md."
echo "Você deseja prosseguir com esta instalação? (responda apenas S para sim ou N para não)"
read CONTINUE

if [ $CONTINUE = "N" ]
then
    exit
fi

# == DETALHES ==
# O comando "read" é um comando interativo, pois ele aguarda uma resposta do usuário. O texto colocado na sua sequência (no caso "CONTINUE") é definido por você, programador, e transforma-se, automaticamente, numa variável dentro do contexto deste programa.
# No caso deste programa, a variável "CONTINUE" está sendo usada dentro do IF como "$CONTINUE" (o $ é o que indicada para o sistema que aquilo que está sendo chamado é uma variável).

# =====================
# = Setting variables =
# =====================

DIR_PATH=$(pwd)

# ===================
# = Config .profile =
# ===================

cd ~
cp ~/.profile .profile.backup
cp $DIR_PATH/library/profile-sample .profile
cat .profile.backup >> .profile

# ===================
# = Config terminal =
# ===================

touch /etc/inputrc
cat $DIR_PATH/library/inputrc-sample >> /etc/inputrc