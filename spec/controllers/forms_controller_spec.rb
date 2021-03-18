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

  it 'post step 2' do

    # Given Account and payload
    account = create(:account)
    researcher = create(:researcher, employee_id: account.employee_id)
    request.headers['Authorization'] = token(account)
    state_payload = create_state_params
    foundation_payload = create_foundation_params
    student_payload = create_student_params
    productivity_payload = create_productivity_params

    # When POST step 2
    post :step, params: {
                          step: 2,
                          '0': state_payload,
                          '1': foundation_payload,
                          '2': student_payload,
                          '3': productivity_payload }

    # Should
    # update Account completed steps,
    # create State employee, Foundation employee, Intern, Scholarship and ProductivityGrant
    updated_account = Account.find(account.id)
    state_employee_name = state_payload[:items][0][:name]
    state_employee = Employee.find_by(name: state_employee_name)

    foundation_employee_name = state_payload[:items][0][:name]
    foundation_employee = Employee.find_by(name: foundation_employee_name)

    intern_name = student_payload[:items][0][:name]
    intern = Intern.find_by(name: intern_name)

    scholarship_number = student_payload[:items][0][:scholarships][0][:process_number]
    scholarship = Scholarship.find_by(process_number: scholarship_number)

    grant = ProductivityGrant.find_by(researcher_id: researcher.id)

    expect(updated_account.completed_steps[2]).to be(true)
    expect(state_employee.name).to eq(state_employee_name)
    expect(foundation_employee.name).to eq(foundation_employee_name)
    expect(intern.name).to eq(intern_name)
    expect(scholarship.process_number).to eq(scholarship_number)
    expect(grant.researcher_id).to eq(researcher.id)
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

  it 'post step 4' do

    # Given Account and payload
    account = create(:account)
    researcher = create(:researcher, employee_id: account.employee_id)
    request.headers['Authorization'] = token(account)
    advisement = create(:advisement, researcher_id: researcher.id)
    thesis_payload = create_thesis_params(advisement.id)
    accreditation_payload = create_accreditation_params
    class_payload = create_class_params
    lecture_payload = create_lecture_params
    coordination_payload = create_coordination_params

    # When POST step 4
    post :step, params: {
                          step: 4,
                          '0': thesis_payload,
                          '1': accreditation_payload,
                          '2': class_payload,
                          '3': lecture_payload,
                          '4': coordination_payload }

    # Should
    # update Account completed steps,
    # create Thesis, Accreditation, Subject, MinisteredClass, Lecture and CourseCoordination
    thesis_institution_id = thesis_payload[:items][0][:institution][:value]
    thesis = Thesis.find_by(institution_id: thesis_institution_id)

    accreditation_postgraduate_id = accreditation_payload[:items][0][:postgraduate_program][:value]
    accreditation = Accreditation.find_by(postgraduate_program_id: accreditation_postgraduate_id)

    subject_name = class_payload[:items][0][:name]
    subject = Subject.find_by(name: subject_name)

    class_subject_id = subject.id
    clazz = MinisteredClass.find_by(subject_id: class_subject_id)

    lecture_name = lecture_payload[:items][0][:name]
    lecture = Lecture.find_by(name: lecture_name)

    coordination_name = coordination_payload[:items][0][:name]
    coordination = CourseCoordination.find_by(name: coordination_name)

    updated_account = Account.find(account.id)

    expect(updated_account.completed_steps[4]).to be(true)
    expect(thesis.institution_id).to eq(thesis_institution_id)
    expect(accreditation.postgraduate_program_id).to eq(accreditation_postgraduate_id)
    expect(subject.name).to eq(subject_name)
    expect(clazz.subject_id).to eq(class_subject_id)
    expect(lecture.name).to eq(lecture_name)
    expect(coordination.name).to eq(coordination_name)

  end

  it 'post step 5' do

    # Given Account and payload
    account = create(:account)
    researcher = create(:researcher, employee_id: account.employee_id)
    request.headers['Authorization'] = token(account)
    grant_payload = create_grant_params

    # When POST step 5
    post :step, params: {
                          step: 5,
                          '0': grant_payload }

    # Should
    # update Account completed steps,
    # create Grant
    grant_process_number = grant_payload[:items][0][:process_number]
    grant = Grant.find_by(process_number: grant_process_number)

    updated_account = Account.find(account.id)

    expect(updated_account.completed_steps[5]).to be(true)
    expect(grant.researcher_id).to eq(researcher.id)
    expect(grant.process_number).to eq(grant_process_number)
    expect(response).to have_http_status(:ok)
  end

  it 'post step 6' do

    # Given Account and payload
    account = create(:account)
    researcher = create(:researcher, employee_id: account.employee_id)
    request.headers['Authorization'] = token(account)
    activity_payload = create_activity_params

    # When POST step 6
    post :step, params: {
                          step: 6,
                          '0': activity_payload }

    # Should
    # update Account completed steps,
    # create Activity
    activity_type_id = activity_payload[:items][0][:activity_type_id]
    activity = Activity.find_by(activity_type_id: activity_type_id)

    updated_account = Account.find(account.id)

    expect(updated_account.completed_steps[6]).to be(true)
    expect(activity.activity_type_id).to eq(activity_type_id)
    expect(response).to have_http_status(:ok)
  end

  it 'post step 7' do

    # Given Account and payload
    account = create(:account)
    researcher = create(:researcher, employee_id: account.employee_id)
    request.headers['Authorization'] = token(account)
    note_payload = create_note_params

    # When POST step 7
    post :step, params: {
                          step: 7,
                          '0': note_payload }

    # Should
    # update Account completed steps,
    # create Note
    note_note = note_payload[:items][0][:note]
    note = Note.find_by(note: note_note)

    updated_account = Account.find(account.id)

    expect(updated_account.completed_steps[7]).to be(true)
    expect(note.note).to eq(note_note)
    expect(response).to have_http_status(:ok)
  end

  def create_note_params
    {
      items: [
        {
          note: Faker::Alphanumeric.alphanumeric(number: 42)
        }
      ]
    }
  end

  def create_activity_params
    {
      items: [
        {
          activity_type_id: create(:activity_type).id,
          sub_activity_type_id: create(:sub_activity_type).id,
        }
      ]
    }
  end

  def create_grant_params
    {
      items: [
        {
          grant_project_type_id: create(:grant_project_type).id,
          grant_participation_type_id: create(:grant_participation_type).id,
          grant_currentness_id: create(:grant_currentness).id,
          funding_agency_id: create(:funding_agency).id,
          process_number: Faker::Alphanumeric.alphanumeric(number: 12)
        }
      ]
    }
  end

  def create_thesis_params(adv_id)
    {
      items: [
        {
          institution: {
            value: create(:institution).id
          },
          advisement: {
            value: adv_id
          }
        }
      ]
    }
  end

  def create_accreditation_params
    {
      items: [
        {
          postgraduate_program: {
            value: create(:postgraduate_program).id
          },
          institution: {
            value: create(:institution).id
          },
          degree: {
            value: create(:course_degree).id
          }
        }
      ]
    }
  end

  def create_class_params
    {
      items: [
        {
          name: Faker::Adjective::positive,
          postgraduate_program_id: create(:postgraduate_program).id,
          institution_id: create(:institution).id
        }
      ]
    }
  end

  def create_lecture_params
    {
      items: [
        {
          name: Faker::Adjective::positive,
          institution_id: create(:institution).id
        }
      ]
    }
  end

  def create_coordination_params
    {
      items: [
        {
          name: Faker::Adjective::positive,
          course_classification_id: create(:course_classification).id
        }
      ]
    }
  end

  def create_state_params
    {
      items: [
        {
          name: Faker::Name::first_name,
          role_foundation_level_id: create(:role_foundation_level).id,
          title_id: create(:title).id
        }
      ]
    }
  end

  def create_foundation_params
    {
      items: [
        {
          name: Faker::Name::first_name,
          role_foundation_level_id: create(:role_foundation_level).id,
          title_id: create(:title).id
        }
      ]
    }
  end

  def create_student_params
    {
      items: [
        {
          name: Faker::Name::first_name,
          advisement_degree: {
            value: create(:advisement_degree).id
          },
          scholarships: [
            {
              process_number: '123',
              funding_agency_id: create(:funding_agency).id
            }
          ]
        }
      ]
    }
  end

  def create_productivity_params
    {
      items: [
        {
          postdoc_name: Faker::Name::first_name,
          productivity_grant_type: {
            value: create(:productivity_grant_type).id
          }
        }
      ]
    }
  end

  def create_paper_params
    {
      items: [{
                doi: '123312',
                qualis: {
                  value: create(:qualis).id },
                collaboration_type: {
                  value: create(:collaboration_type).id
                },
                postdoc: [
                  { value: create(:intern).id }
                ],
                phd: [
                  { value: create(:intern).id }
                ],
                msc: [
                  { value: create(:intern).id }
                ],
                ic: [
                  { value: create(:intern).id }
                ]
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
                },
                postdoc: [
                  { value: create(:intern).id }
                ],
                phd: [
                  { value: create(:intern).id }
                ],
                msc: [
                  { value: create(:intern).id }
                ],
                ic: [
                  { value: create(:intern).id }
                ]
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
