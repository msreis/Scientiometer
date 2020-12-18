class ResearcherService

  def self.create_researcher(params, employee_id)
    researcher = Researcher.new
    researcher.researcher_id = params[:researcher_id]
    researcher.ORCID = params[:orcid]
    researcher.email = params[:email]
    researcher.employee_id = employee_id
    researcher.post_doc_type_id = params[:post_doc_type_id]
    researcher.ingress_date = params[:ingress_date]

    researcher.save!
    researcher
  end

end
