#! /usr/bin/env ruby


# auteur: jvtrudel
# date: novembre 2017

# # Objectif
#
# Prend un fichier au format csv et retourne le au format yaml.
# le header est obligatoire en ne doit contenir aucun espace et que des caractères ASCII
# (la plupart des implémentations yaml ne gère que de l'ASCII pour les tags)
# 
# CSV:
#
#     id, name, adresse, lat, lon
#     1, Bob, 12 rue du moulin rimouski, 12, -14
#     2, Alice, 13 desChênes Padou, 13, -15
#
# YAML
#
#     - id: 1
#       name: Bob
#       adresse: 12 rue du moulin rimouski
#       lat: 12
#       lon: -14  
#     - id: 1
#       name: Bob
#       adresse: 13 desChênes Padou
#       lat: 13
#       lon: 15




require 'csv'
require 'yaml'
require 'optparse'


options = {}
OptionParser.new do |opts|
  opts.banner = "csv_reformat
  Outils de manipulation de fichier csv.
  Usage: example.rb [options]"

  opts.on("-a", "--add_id", "Add an id to each line") do |a|
    options[:add_id] = a
  end
  opts.on("-s [SEP]","--separator [SEP]", "Separator is sep") do |s|
  	options[:separator]=s
  end
  opts.on("-S [SEP]","--output_separator [SEP]", "Output separator is sep") do |r|
  	options[:output_separator]=r
  end

  opts.on("-h","--headers","have headers describing columns") do |h|
  	options[:headers]=h
  end

  opts.on("-c CONTENT","--content CONTENT", "Output content") do |c|
  	options[:content]=c
  end
  opts.on("-v","--verbose", "Verbose mode") do |v|
  	options[:verbose]=v
  end

end.parse!



csv_options={}




case
	when options[:separator]
		csv_options[:col_sep]=options[:separator]
end
case
  when options[:output_separator]
  	options[:output_separator]=options[:output_separator]
  else
  	options[:output_separator]=options[:separator]
end
case 
when !options[:headers]
	fail "le fichier doit contenir un header"
	
end

#puts options
#puts csv_options



case
	when options[:verbose]
		puts "[+] verbose: #{options[:verbose]}"
		puts "[+] add_id: #{options[:add_id]}" 
  		puts "[+] separator: #{options[:separator]}"
  		puts "[+] header: #{options[:headers]}"
  		puts "[+] content: #{options[:content]}"
        puts ""
  		puts "case 1: #{options[:add_id]&&options[:content]}"
  		puts "case 2: #{!options[:add_id]&& !options[:content]}"
end








data=[]

if (options[:content])
	case
	  when options[:headers]
	  	csv_options[:headers]=true
	end
	csv=CSV.new( ARGF ,csv_options)
    keys=options[:content].split(csv_options[:col_sep])
else
	csv=CSV.new( ARGF ,csv_options)
    keys=csv.shift
end

if(options[:add_id]&&options[:content])
	# warning if id already exist
	keys.unshift('id')
	id=0
   csv.each do |line| 
	  line["id"]=id
      data.push(line)
	  id+=1
   end 
   data.each do |line|
	    text="- " 
	    keys.each do |col|
	        text+="#{col}: #{line[col]}\n"
	    end
	    puts text
	end
elsif (!options[:add_id]&& !options[:content])
	#puts "data:"
   csv.each do |line| 
	    text="- "+"#{keys[0]}: \"#{line[0]}\"\n"
	    (1..keys.length-1).each do |idx|
	        text+="  #{keys[idx]}: \"#{line[idx]}\"\n"
	    end
	    puts text
   end 
end









