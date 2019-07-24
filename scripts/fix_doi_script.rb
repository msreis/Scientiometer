File.open(ARGV[0]) do |dois|
    dois.each_line do |line|
        doi = line.scan(/[0-9][0-9].[0-9]{4,5}\/.*/)[0]
        id = line.scan(/([0-9]+)\t/)[0][0]
        doi = "\"" + doi +"\"" if doi
        doi = "NULL" if not doi
        sql = "UPDATE published_work SET doi_url = #{doi} WHERE id = #{id.to_s};"
        puts sql unless doi == "NULL"
    end
end