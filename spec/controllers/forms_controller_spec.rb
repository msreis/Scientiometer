require 'rails_helper'
require 'support/login_helper'

RSpec.describe FormsController, type: :controller do

  it 'post step 1' do

    # Given Account and payload
    account = create(:account)
    request.headers['Authorization'] = token(account)
    payload = create_payload

    # When POST step 1
    post :step, params: { step: 1, '0': payload }

    # Should
    # update Account completed steps,
    # create Employee, Researcher and Submission
    updated_account = Account.find(account.id)
    employee = Employee.find_by(:name => payload[:name])
    researcher = Researcher.find_by(:orcid => payload[:orcid])
    submission = Submission.find_by(account_id: account.id)

    expect(submission.date).to eq(CurrentYear.current_year)
    expect(updated_account.completed_steps[1]).to be(true)
    expect(updated_account.employee_id).to be(employee.id)
    expect(researcher.employee_id).to be(employee.id)
    expect(response).to have_http_status(:ok)

  end

  it 'post step 3' do

    # Given Account and payload
    account = create(:account)
    researcher = create(:researcher, employee_id: account.employee_id)
    request.headers['Authorization'] = token(account)
    paper_payload = create_paper_params
    book_payload = create_book_params
    scientometric_payload = create_scientometric_params
    congress_payload = create_congress_params

    # When POST step 3
    post :step, params: {
                          step: 3,
                          '0': paper_payload,
                          '1': book_payload,
                          '2': scientometric_payload,
                          '3': congress_payload }

    # Should
    # update Account completed steps,
    # create Article, ResearcherPaper, Book, ResearcherBook, ScientometricIndex, Cogress, CongressParticipation
    article_doi = paper_payload[:items][0][:doi]
    article = Article.find_by(doi_url: article_doi)

    researcher_paper = ResearcherPaper.find_by(article: article, researcher_id: researcher.id)

    book_doi = book_payload[:items][0][:doi]
    book = Book.find_by(doi_url: book_doi)

    researcher_book = ResearcherBook.find_by(book_id: book.id, researcher_id: researcher.id)

    scientometric_index_citations_wos = scientometric_payload[:citations_wos]
    scientometric_index = ScientometricIndex.find_by(researcher_id: researcher.id)

    congress_name = congress_payload[:items][0][:name]
    congress_role_id = congress_payload[:items][0][:congress_role_id]
    congress = Congress.find_by(name: congress_name)
    congress_participation = CongressParticipation.find_by(congress_id: congress.id, researcher_id: researcher.id)

    updated_account = Account.find(account.id)

    expect(updated_account.completed_steps[3]).to be(true)
    expect(article.DOI_url).to eq(article_doi)
    expect(researcher_paper.article).to eq(article)
    expect(book.DOI_url).to eq(book_doi)
    expect(researcher_book.book_id).to eq(book.id)
    expect(scientometric_index.citations_wos).to eq(scientometric_index_citations_wos)
    expect(congress.name).to eq(congress_name)
    expect(congress_participation.congress_role_id).to eq(congress_role_id)
    expect(response).to have_http_status(:ok)
  end

  def create_paper_params
    {
      items: [{
                doi: '123312',
                qualis: {
                  value: create(:qualis).id },
                collaboration_type: {
                  value: create(:collaboration_type).id
                }
              }]
    }
  end

  def create_book_params
    {
      items: [{
                doi: '5678567',
                qualis: {
                  value: create(:qualis).id },
                collaboration_type: {
                  value: create(:collaboration_type).id
                }
              }]
    }
  end

  def create_scientometric_params
    {
      citations_wos: 42,
      citations_gs: 665
    }
  end

  def create_congress_params
    {
      items: [{
                name: 'cog',
                congress_role_id: create(:congress_role).id
              }]
    }
  end

  def create_payload
    create_employee_params.merge(create_researcher_params)
  end

  def create_employee_params
    {
      name: 'abc',
      laboratory_id: create(:laboratory).id,
      role_foundation_level_id: create(:role_foundation_level).id,
      title_id: create(:title).id
    }
  end

  def create_researcher_params
    {
      orcid: 23123123,
      email: 'e@mail.com',
      post_doc_type_id: create(:post_doc_type).id,
      ingress_date: '2020-02-01'
    }
  end

end
