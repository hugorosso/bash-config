#!/bin/sh

# ===============
# = Checking OS =
# ===============

if [ $(uname) = "Darwin" ]
then
    echo "Sistema operacional identificado: Mac OS"
elif [ $(uname) = "Linux" ]
then
    echo "Sistema operacional identificado: Linux"
else
    echo "Este programa não é compatível com seu sistema operacional. Por gentileza, leia o arquivo README.md."
    exit
fi

# =============================
# = Checking user permissions =
# =============================

if [ $(id -u) != 0 ]
then
    echo "Para funcionar corretamente, este programa precisa ser executado com permissões de super usuário (sudo). Por gentileza, execute o comando de conforme abaixo:"
    echo "sudo ./config.sh"
    exit
fi

# =================================== 
# = User validation - .profile file =
# ===================================

echo "Olá. Este programa mudará a configuração atual do seu arquivo ~/.profile, que é o arquivo responsável pela configuração do seu terminal. Caso você já use uma versão customizada do seu terminal, recomendo que você cancele esta instalação e leia o arquivo README.md."
echo "Você deseja prosseguir com esta instalação? (responda apenas S para sim ou N para não)"
read CONTINUE

if [ $CONTINUE = "N" ]
then
    exit
fi

# =====================
# = Setting variables =
# =====================

DIR_PATH=$(pwd)

# ===================
# = Config .profile =
# ===================

if [ $(uname) = "Darwin" ]
then
    cd ~
    cp ~/.profile .profile.backup
    cp $DIR_PATH/library/profile-sample .profile
    cat .profile.backup >> .profile
elif [ $(uname) = "Linux" ]
then
    cd ~
    cp ~/.bashrc .bashrc.backup
    cat $DIR_PATH/library/profile-sample >> .bashrc
fi

# ==================================
# = Exteding terminal capabilities =
# ==================================

if [ $(uname) = "Darwin" ]
then
    touch /etc/inputrc
    cat $DIR_PATH/library/inputrc-sample >> /etc/inputrc
elif [ $(uname) = "Linux" ]
then
    cat $DIR_PATH/library/inputrc-sample >> /etc/inputrc
fi