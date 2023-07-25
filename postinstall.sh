#!/bin/bash

# Fonction pour afficher du texte en vert
print_green() {
  echo -e "\033[32m$1\033[0m"
}

# Fonction pour afficher du texte en bleu
print_blue() {
  echo -e "\033[34m$1\033[0m"
}

# Étape 1: Mise à jour des listes de paquets
print_blue "Étape 1: Mise à jour des listes de paquets"
apt update -y

# Étape 2: Installation des paquets nécessaires
print_blue "Étape 2: Installation des paquets nécessaires"
apt -y install software-properties-common curl ca-certificates gnupg2 sudo lsb-release

# Étape 3: Ajout du dépôt pour PHP
print_blue "Étape 3: Ajout du dépôt pour PHP"
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list

curl -fsSL https://packages.sury.org/php/apt.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/sury-keyring.gpg

# Étape 4: Ajout du dépôt pour Redis
print_blue "Étape 4: Ajout du dépôt pour Redis"
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list

# Étape 5: Mise à jour des listes de paquets
print_blue "Étape 5: Mise à jour des listes de paquets"
apt update -y

# Étape 6: Installation de PHP et des extensions requises
print_blue "Étape 6: Installation de PHP et des extensions requises"
apt install -y php8.1 php8.1-{common,cli,gd,mysql,mbstring,bcmath,xml,fpm,curl,zip}

# Étape 7: Configuration du dépôt MariaDB
print_blue "Étape 7: Configuration du dépôt MariaDB"
curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash

# Étape 8: Installation de Nginx
print_blue "Étape 8: Installation de Nginx"
apt install -y nginx

# Étape 9: Installation des dépendances restantes
print_blue "Étape 9: Installation des dépendances restantes"
apt install -y mariadb-server tar unzip git redis-server

# Fin du script
print_green "Installation terminée!"
