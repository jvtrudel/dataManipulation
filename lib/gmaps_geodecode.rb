#! /usr/bin/env ruby

# Auteur: jvtrudel
# novembre 2017

# description: >
#    Prend une liste d'adresse et retourne cette liste avec la localisation lat/lon


# 

require 'optparse'
require 'csv'
require 'google_maps_service'


options={}

OptionParser.new do |opts|
   opts.banner="gmaps_geodecode"

  opts.on("-s [SEP]","--separator [SEP]", "Separator is SEP") do |s|
  	options[:separator]=s
  end
  opts.on("-S [SEP]","--output_separator [SEP]", "Output separator is sep") do |r|
  	options[:output_separator]=r
  end
  opts.on("-h","--headers","Have headers describing columns") do |h|
  	options[:headers]=h
  end

  opts.on("-k KEY","--keys KEY", "GOOGLE GEODECOE API KEY") do |k|
	options[:key]=k
  end

end.parse!


csv_options={}

case
  when options[:separator]
    csv_options[:col_sep]=options[:separator]
  else
  	options[:separator]=","
  	csv_options[:col_sep]=","
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



adresses= []

gmaps = GoogleMapsService::Client.new(key: options[:key])



csv=CSV.new( ARGF,csv_options )


csv.each do |line|
  #puts line
  adress=line[1]
  #puts "adress: #{adress}"
  # pas très efficace, mais on s'en fout... ça marche!
  good=true
  lat=nil
  lon=nil
  adresses.each do | adress_done|
    good=false
    #puts "#{adress} ==? #{adress_done}"
    break if adress === adress_done
    good=true
  end
  #puts "good? #{good}"

  if good
    adresses.push(adress)
	  results = gmaps.geocode(adress)
	  begin
	    lat=results[0][:geometry][:viewport][:northeast][:lat]
      lon=results[0][:geometry][:viewport][:northeast][:lng]
      text="#{line[0]};#{line[1]};#{lat};#{lon}"
	    puts text
	  rescue 
      i=0
    end
  end
end

#  Si authentification échoue ?

# 1- lit le fichier

# 2- décode:  results = gmaps.geocode(addresse)

# 3- retourne les valeurs





