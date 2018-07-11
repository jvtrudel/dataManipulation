#! /usr/bin/env ruby

# Auteur: jvtrudel
# lire une liste de données csv et faire une opération avec...


# # Options csv 
#   Ces options se retrouvent juste après la commande principale
#
#  - --sep:  Séparateur de champ. Par défaut, ","
#  - --header: Présence d'une ou plusieurs ligne header. Par défaut, false.



# Commandes
#   Les commandes déterminent l'action à faire sur la liste csv. Il est possible d'activer plusueurs commandes simmultanément. Les commandes n'ont pas de tiret.

## to_db: mettre dans une base de données mysql via rails
## geo_decode: Geodecodage d'une adresse avec google



require 'csv'


target=ARGV[0];

# target exists

data=CSV.read(target)


data.each do |datum|
	puts datum
end

