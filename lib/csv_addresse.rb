#! /usr/bin/env ruby


# auteur: jvtrudel
# date: novembre 2017



require 'optparse'
require 'csv'

options = {}
OptionParser.new do |opts|
	opts.banner = "csv_addresse
  Outils de manipulation de fichier csv spécialisé en normalisation d'addresse."

  opts.on("-s [SEP]","--separator [SEP]", "Separator is SEP") do |s|
  	options[:separator]=s
  end
  opts.on("-S [SEP]","--output_separator [SEP]", "Output separator is sep") do |r|
  	options[:output_separator]=r
  end
  opts.on("-h","--headers","Have headers describing columns") do |h|
  	options[:headers]=h
  end

  #opts.on("-m", "--map", "Address components mapping") do |m|
  #	options[:map]=m
  #end

  opts.on("-p PORTE", "--no-porte PORTE", "Tag du No. de porte") do |o|
  	 options[:porte]=o
  end

  opts.on("-P PORTE", "--index-no-porte PORTE", Integer, "Index du No. de porte") do |o|
  	 options[:iporte]=o
  end

  opts.on("-r RUE", "--rue RUE", "Tag du Nom de la rue") do |r|
  	options[:rue]=r
  end

  opts.on("-R RUE", "--rue RUE", Integer, "Index du Nom de la rue") do |r|
  	options[:irue]=r
  end

  opts.on("-C CODEPOSTAL", "--index-postal_code CODEPOSTAL", Integer,"Tag du Code postal") do |c|
  	options[:ipostal_code]=c
  end

  opts.on("-v [VILLE]", "--ville [VILLE]", "Tag de la Ville") do |v|
  	options[:ville]=v
  end

  opts.on("-V [VILLE]", "--index-ville [VILLE]", "index de la Ville") do |v|
  	options[:iville]=v
  end
  opts.on("--gV [VILLE]", "--Ville [VILLE]", "Ville définie glabalement") do |v|
  	options[:Ville]=v
  end

  opts.on("-a POSITION", "--addresse_position POSITION", "Position de l'addresse") do |a|
  	options[:a]=a
  end

end.parse!

if(options.key?(:porte)|| options.key(:iporte))
	raise OptionParser::MissingArgument, "un Tag pointant vers le numéro de porte est nécessaire"
end

if(options.key?(:rue)|| options.key(:irue))
	raise OptionParser::MissingArgument, "un Tag pointant vers le numéro de rue est nécessaire"
end


csv_options={}


case
  when options[:separator]
    csv_options[:col_sep]=options[:separator]
end
case
  when options[:headers]
  	csv_options[:headers]=true
end

case
  when options[:output_separator]
  	options[:output_separator]=options[:output_separator]
  else
  	options[:output_separator]=options[:separator]
end



data=[]

#si pas


keys = [options[:iporte]-1, options[:irue]-1, options[:ipostal_code]-1]


csv=CSV.new( ARGF ,csv_options)


csv.each do |line|

	puts "#{line[0]}; #{line[keys[0]]} #{line[keys[1]]}, #{options[:Ville]}"

end

=begin
keys=options[:content].split(",")

if(options[:add_id])
	# warning if id already exist
	id=0
   csv.each do |line| 
	  line["id"]=id
      data.push(line)
	  id+=1
   end 
end



data.each do |line|
   # text="" 
    #options[:content].each do |col|
    #	text+=line[col]
    #end
    	  text="" 
      keys.each do |col|
         text+="#{line[col]}"+"#{options[:output_separator]}"
      end
      text=text[0..-2]
    puts text
end


=end