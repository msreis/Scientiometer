# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'open-uri'

module Crossref
  BASE_URL = 'https://www.crossref.org/openurl/?noredirect=true&format=unixref'
  VERSION  = '0.0.4'

  class << self
    def valid_doi?(doi)
      !!(doi =~ %r{^10[.]\d+/}) # Very loose validation, just checks the core basics.
    end

    def url(doi, pid = nil)
      url = BASE_URL.dup
      url << "&id=doi:#{sanitize_param(doi)}"
      url << "&pid=#{sanitize_param(pid)}" if pid
      url
    end

    def sanitize_param(param)
      CGI.escape(param.gsub(/\n+|\s+/, ''))
    end
  end

  class Metadata
    attr_accessor :doi, :url, :xml

    def initialize(opts = {})
      @pid = opts[:pid]
      @doi = opts[:doi]
      @doi = @doi.strip if @doi
      @url = Crossref.url(@doi, @pid)

      @xml = get_xml(@url) if @doi && @pid && Crossref.valid_doi?(@doi)
    end

    def valid?
      xml && xpath_ns('error').empty?
    end

    def result?
      if xml.nil? || xpath_ns('error').size == 1
        false
      else
        xpath_ns('doi_record').size == 1
      end
    end

    def title
      return nil unless valid?

      xpath_first('titles/title')
    end

    def first_author
      return {} unless valid?

      xpath_ns('contributors/person_name[@contributor_role="author" and @sequence="first"]').each do |a|
        return hashify_nodes(a.children)
      end

      {}
    end

    def authors
      return [] unless valid?

      authors = []
      xpath_ns('contributors/person_name[@contributor_role="author"]').each do |a|
        authors << hashify_nodes(a.children)
      end
      authors
    end

    def published
      return {} unless valid?

      pub = {}
      pub[:year] = xpath_first('publication_date/year')
      pub[:month] = xpath_first('publication_date/month')
      pub
    end

    def journal
      return {} unless valid?
      return {} if xpath_ns('journal_metadata').to_s == ''

      journal = hashify_nodes(xpath_ns('journal_metadata')&.first&.children)
      journal[:volume] = xpath_first('journal_issue/journal_volume/volume')
      journal[:issue] = xpath_first('journal_issue/issue')
      journal[:first_page] = xpath_first('first_page')
      journal[:last_page] = xpath_first('last_page')

      journal
    end

    def resource
      xpath_first('doi_data/resource')
    end

    def xpath_ns(q)
      xml.xpath("//#{q}")
    end

    def xpath_first(q)
      if info = xpath_ns(q).first
        info.content
      end
    end

    #------------------------------------------------------
    private

    def get_xml(url)
      Nokogiri::XML(open(url))
    end

    def hashify_nodes(nodes)
      h = {}
      nodes.each do |node|
        h[node.name.to_sym] = node.content unless node.content.match(/\n/)
      end
      h
    end
  end
end
