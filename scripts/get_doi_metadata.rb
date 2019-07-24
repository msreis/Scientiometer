require 'bibtex'
require 'set'

doi_list = Set.new()

File.open(ARGV[0]) do |dois|
    dois.each_line do |line|
        doi = line.scan(/[0-9][0-9].[0-9]{4,5}\/.*/)[0]
        id = line.scan(/([0-9]+)\t/)[0][0]
        if doi and not doi_list.include? doi
            doi_list.add doi
        end
    end
    puts doi_list.length
    doi_list.each do |doi|
        metadata = `curl -LsH "Accept: text/bibliography; style=bibtex" http://doi.org/#{doi}`
        # puts "http://doi.org/#{doi}"
        # puts metadata
        b = BibTeX.parse metadata
        b = b[0]
        print doi + "|"
        begin
            # author is an array of authors
            if b.author.length > 5
                max = 5
            else max = b.author.length - 1
            end
            0.upto max do |i|
                *last_names, last_name = b.author[i].last.split(" ")
                print last_name
                print " "
                first_names = b.author[i].first.split(" ")
                first_names.each {|name| print name[0] unless name[0] == name[0].downcase}
                last_names.each {|name| print name[0] unless name[0] == name[0].downcase}
                print ", " unless i == max
            end
            if max < 5
                print ". "
            else
                print " et al. "
            end

            print "#{b[:title]}. "
            print "#{b[:journal]}. "
            print "#{b[:year]};"
            print "#{b[:volume]}"
            print "(#{b[:number]})" if b[:number]
            print ":#{b[:pages]}" if b[:pages]
            puts
        rescue StandardError => e
            puts
        end
    end
end

