#! /usr/bin/env ruby


# auteur: jvtrudel
# date: novembre 2017

# # csv_reformat
#
#   Outils de manipulation de fichier csv


# commandes:
#
# add_id: ajout d'un id
#  options:
#    long_tag: format
#    short_tag: f
#    defaut:  sequentiel
#    choices:
#       - sequentiel
#       - uuid

require 'optparse'
require 'csv'

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


end.parse!



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


#puts options
#puts csv_options


csv=CSV.new( ARGF ,csv_options)


data=[]


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
