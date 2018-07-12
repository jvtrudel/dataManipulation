#
#

require 'optparse'

options={}
options[:headers]=false
options[:separator]=";"
options[:output_separator]=";"
OptionParser.new do |opts|
   opts.banner="Parse options

   "
   opts.on("-s [SEP]","--separator [SEP]", "Separator is sep") do |s|
   	options[:separator]=s
   end
   opts.on("-S [SEP]","--output_separator [SEP]", "Output separator is sep") do |r|
   	options[:output_separator]=r
   end

   opts.on("-h","le csv a un header") do |h|
      options[:headers]=h
   end

   opts.on("--Caddr [COL]","Colonne de l'addresse") do |a|
      options[:Caddr]=a
   end

   opts.on("-Cporte [COL]","colonne numéro de porte") do |r|
      options[:Cporte]=r
   end

   opts.on("-Crue [COL]","colonne rue") do |r|
      options[:Crue]=r
   end

   opts.on("-CcodePostal [COL]","colonne rue") do |r|
      options[:CcodePostal]=r
   end

   opts.on("-Cnom [COL]","colonne rue") do |r|
      options[:Cnom]=r
   end

   opts.on("-Cprenom [COL]","colonne rue") do |r|
      options[:Cprenom]=r
   end

   opts.on("-Cville [COL]","colonne rue") do |r|
      options[:Cville]=r
   end


   opts.on("--addr [COL]","Colonne de l'addresse") do |a|
      options[:Caddr]=a
   end

   opts.on("-porte [COL]","colonne numéro de porte") do |r|
      options[:Cporte]=r
   end

   opts.on("-rue [COL]","colonne rue") do |r|
      options[:Crue]=r
   end

   opts.on("-codePostal [COL]","colonne rue") do |r|
      options[:CcodePostal]=r
   end

   opts.on("-nom [COL]","colonne rue") do |r|
      options[:nom]=r
   end

   opts.on("-prenom [COL]","colonne rue") do |r|
      options[:prenom]=r
   end

   opts.on("-ville [COL]","colonne rue") do |r|
      options[:ville]=r
   end

end.parse!
