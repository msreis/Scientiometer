require "#{Rails.root}/lib/crossref"

class DoiController < ApplicationController

    def resolve
        cr = Crossref::Metadata.new(pid: "bruno.scholl@usp.br", doi: params[:doi])
        paper = {
            doi: cr.doi,
            title: cr.title,
            authors: cr.authors,
        }
        render json: paper
    end
end