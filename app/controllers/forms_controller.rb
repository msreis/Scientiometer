# frozen_string_literal: true

require 'current_year'

class FormsController < ApplicationController
  before_action :authorize_request

  # Researcher creation
  def step1
    puts 'step 1'
    filt_params = params['0']

    ActiveRecord::Base.transaction do
      # verify if whole step was done
      employee = Employee.new
      employee.name = filt_params[:name]
      employee.is_foundation = true
      employee.laboratory_id = filt_params[:laboratory_id]
      employee.role_foundation_level_id = filt_params[:role_foundation_level_id]
      employee.title_id = filt_params[:title_id]

      employee.save!

      researcher = Researcher.new
      researcher.researcher_id = filt_params[:researcher_id]
      researcher.ORCID = filt_params[:orcid]
      researcher.email = filt_params[:email]
      researcher.employee_id = employee[:id]
      researcher.post_doc_type_id = filt_params[:post_doc_type_id]
      researcher.ingress_date = filt_params[:ingress_date]

      researcher.save!

      @current_account.employee_id = employee[:id]
      @current_account.add_step 1
      @current_account.save!
    end
  end

  def step2
    puts 'step 2'

    current_employee = Employee.find(@current_account[:employee_id])

    state_employees = params['0'][:items]
    found_employees = params['1'][:items]
    students = params['2'][:items]
    prod_grants = params['3'][:items]

    ActiveRecord::Base.transaction do
      # Rollback all if something fails
      state_employees&.each do |entry|
        employee = Employee.new
        employee.name = entry[:name]
        employee.is_foundation = false
        employee.role_foundation_level_id = entry[:role_foundation_level_id]
        employee.laboratory_id = current_employee[:laboratory_id]
        employee.title_id = entry[:title_id]
        employee.submission_id = current_submission[:id]

        employee.save!
      end

      found_employees&.each do |entry|
        employee = Employee.new
        employee.name = entry[:name]
        employee.is_foundation = true
        employee.role_foundation_level_id = entry[:role_foundation_level_id]
        employee.laboratory_id = current_employee[:laboratory_id]
        employee.title_id = entry[:title_id]
        employee.submission_id = current_submission[:id]

        employee.save!
      end

      students&.each do |entry|
        intern = Intern.new
        intern.name = entry[:name]
        intern.submission_id = current_submission[:id]

        intern.save!

        advisement = Advisement.new
        advisement.advisement_degree_id = entry[:advisement_degree][:value]
        advisement.researcher_id = current_researcher[:id]
        advisement.intern_id = intern[:id]
        advisement.supervisor_is_postdoc = entry[:postdoc]
        advisement.submission_id = current_submission[:id]
        advisement.validity_start = entry[:validity_start]
        advisement.validity_end = entry[:validity_end]

        advisement.save!

        entry[:scholarships].each do |ship_entry|
          scholarship = Scholarship.new
          scholarship.advisement_id = advisement[:id]
          scholarship.funding_agency_id = ship_entry[:funding_agency_id]
          scholarship.process_number = ship_entry[:process_number]
          scholarship.total_value_BRL = ship_entry[:value_BRL]
          scholarship.total_value_USD = ship_entry[:value_USD]
          scholarship.technical_reserve_BRL = ship_entry[:technical_reserve_BRL]
          scholarship.validity_start = ship_entry[:validity_start]
          scholarship.validity_end = ship_entry[:validity_end]
          scholarship.submission_id = current_submission[:id]

          scholarship.save!
        end
      end

      prod_grants&.each do |entry|
        grant = ProductivityGrant.new
        grant.researcher_id = current_researcher[:id]
        grant.cnpq_level_id = entry[:cnpq_level_id][:value]
        grant.is_fb = entry[:is_fb]
        grant.validity_start = entry[:validity_start]
        grant.validity_end = entry[:validity_end]
        grant.submission_id = current_submission[:id]

        grant.save!
      end

      @current_account.add_step 2
      @current_account.save!
    end
  end

  def step3
    puts 'step 3'
    papers = (params['0'][:items] || [])
    books = (params['1'][:items] || [])

    indices = params['2']
    congresses = (params['3'][:items] || [])

    ActiveRecord::Base.transaction do
      papers.each do |entry|
        paper = Article.find_by(DOI_url: entry[:doi])
        next if paper

        paper = Article.new
        paper.DOI_url = entry[:doi]
        paper.qualis_id = entry[:qualis][:value]
        paper.impact_factor = entry[:impact_factor]
        paper.collaboration_type_id = entry[:collaboration_type][:value]
        paper.year = CurrentYear.current_year
        paper.submission_id = current_submission[:id]

        paper.save!

        participation = ResearcherPaper.new
        participation.article = paper
        participation.researcher_id = current_researcher[:id]
        participation.first_author = entry[:first_author]
        participation.last_author = entry[:last_author]
        participation.corresponding_author = entry[:corresponding_author]
        participation.submission_id = current_submission[:id]

        participation.save!

        entry[:postdocs] ||= []
        entry[:postdocs].each do |entry|
          pd_paper = PostdocPaper.new
          pd_paper.article_id = paper[:id]
          pd_paper.postdoc_id = entry[:value]
          pd_paper.submission_id = current_submission[:id]
          pd_paper.year = CurrentYear.current_year
          pd_paper.save!
        end

        entry[:phd] ||= []
        entry[:phd].each do |entry|
          std_paper = StudentPaper.new
          std_paper.article_id = paper[:id]
          std_paper.intern_id = entry[:value]
          std_paper.submission_id = current_submission[:id]
          std_paper.year = CurrentYear.current_year
          std_paper.save!
        end

        entry[:msc] ||= []
        entry[:msc].each do |entry|
          std_paper = StudentPaper.new
          std_paper.article_id = paper[:id]
          std_paper.intern_id = entry[:value]
          std_paper.submission_id = current_submission[:id]
          std_paper.year = CurrentYear.current_year
          std_paper.save!
        end

        entry[:ic] ||= []
        entry[:ic].each do |entry|
          std_paper = StudentPaper.new
          std_paper.article_id = paper[:id]
          std_paper.intern_id = entry[:value]
          std_paper.submission_id = current_submission[:id]
          std_paper.year = CurrentYear.current_year
          std_paper.save!
        end
      end

      books.each do |entry|
        book = Book.find_by(DOI_url: entry[:doi])
        book ||= Book.find_by(ISBN: entry[:isbn])
        next if book

        book = Book.new
        book.DOI_url = entry[:doi]
        book.ISBN = entry[:isbn]
        book.qualis_id = entry[:qualis][:value]
        book.impact_factor = entry[:impact_factor]
        book.collaboration_type_id = entry[:collaboration_type][:value]
        book.year = CurrentYear.current_year

        book.submission_id = current_submission[:id]

        book.save!

        participation = ResearcherBook.new
        participation.book_id = book[:id]
        participation.researcher_id = current_researcher[:id]
        participation.first_author = entry[:first_author]
        participation.last_author = entry[:last_author]
        participation.corresponding_author = entry[:corresponding_author]

        participation.save!

        entry[:postdocs] ||= []
        entry[:postdocs].each do |entry|
          pd_book = PostdocBook.new
          pd_book.book_id = book[:id]
          pd_book.postdoc_id = entry[:value]
          pd_book.submission_id = current_submission[:id]
          pd_book.year = CurrentYear.current_year
          pd_book.save!
        end

        entry[:phd] ||= []
        entry[:phd].each do |entry|
          std_book = StudentBook.new
          std_book.book_id = book[:id]
          std_book.intern_id = entry[:value]
          std_book.submission_id = current_submission[:id]
          std_book.year = CurrentYear.current_year
          std_book.save!
        end

        entry[:msc] ||= []
        entry[:msc].each do |entry|
          std_book = StudentBook.new
          std_book.book_id = book[:id]
          std_book.intern_id = entry[:value]
          std_book.submission_id = current_submission[:id]
          std_book.year = CurrentYear.current_year
          std_book.save!
        end

        entry[:ic] ||= []
        entry[:ic].each do |entry|
          std_book = StudentBook.new
          std_book.book_id = book[:id]
          std_book.intern_id = entry[:value]
          std_book.submission_id = current_submission[:id]
          std_book.year = CurrentYear.current_year
          std_book.save!
        end
      end

      index = ScientometricIndex.new
      index.researcher_id = current_researcher[:id]
      index.citations_wos = indices[:citations_wos]
      index.citations_gs = indices[:citations_gs]
      index.h_index_gs = indices[:h_index_gs]
      index.h_index_wos = indices[:h_index_wos]
      index.primary_line_of_research_id = indices[:primary_line_of_research_id]
      index.secondary_line_of_research_id = indices[:secondary_line_of_research_id]
      index.year = CurrentYear.current_year
      index.submission_id = current_submission[:id]

      index.save!

      congresses.each do |entry|
        congress = Congress.new
        congress.name = entry[:name]
        congress.country = entry[:country]
        congress.submission_id = current_submission[:id]

        congress.save!

        participation = CongressParticipation.new
        participation.researcher_id = current_researcher[:id]
        participation.congress_id = congress[:id]
        participation.year = CurrentYear.current_year
        participation.congress_role = entry[:congress_role_id]
        participation.submission_id = current_submission[:id]

        participation.save!
      end
      @current_account.add_step 3
      @current_account.save!
    end
  end

  def step4
    puts 'step 4'
    theses = (params['0'][:items] || [])
    accreditations = (params['1'][:items] || [])
    ministered_classes = (params['2'][:items] || [])
    lectures = (params['3'][:items] || [])
    coordinations = (params['4'][:items] || [])

    ActiveRecord::Base.transaction do
      theses.each do |entry|
        thesis = Thesis.new
        thesis.finish_year = CurrentYear.current_year
        thesis.institution_id = entry[:institution][:value]
        thesis.delivery_date = entry[:delivery_date]
        thesis.advisement_id = entry[:advisement][:value]

        thesis.submission_id = current_submission[:id]

        thesis.save!
      end

      accreditations.each do |entry|
        accreditation = Accreditation.new
        accreditation.researcher_id = current_researcher[:id]
        accreditation.postgraduate_program_id = entry[:postgraduate_program][:value]
        accreditation.institution_id = entry[:institution][:value]
        accreditation.course_degree_id = entry[:degree][:value]
        accreditation.year = CurrentYear.current_year

        accreditation.submission_id = current_submission[:id]

        accreditation.save!
      end

      ministered_classes.each do |entry|
        subject = Subject.new
        subject.name = entry[:name]
        subject.code = entry[:code]
        subject.submission_id = current_submission[:id]

        subject.save!

        ministered = MinisteredClass.new
        ministered.postgraduate_program_id = entry[:postgraduate_program_id]
        ministered.institution_id = entry[:institution_id]
        ministered.subject_id = subject[:id]
        ministered.year = CurrentYear.current_year
        ministered.submission_id = current_submission[:id]

        ministered.save!
      end

      lectures.each do |entry|
        lecture = Lecture.new
        lecture.name = entry[:name]
        lecture.lecture_count = entry[:lecture_count]
        lecture.workload = entry[:workload]
        lecture.postgraduate_program_id = entry[:postgraduate_program_id]
        lecture.institution_id = entry[:institution_id]
        lecture.year = entry[:year]
        lecture.submission_id = current_submission[:id]

        lecture.save!
      end

      coordinations.each do |entry|
        coordination = CourseCoordination.new
        coordination.name = entry[:name]
        coordination.course_classification_id = entry[:course_classification_id]
        coordination.coordination_degree_id = entry[:coordination_degree_id]
        coordination.workload = entry[:workload]
        coordination.year = CurrentYear.current_year
        coordination.submission_id = current_submission[:id]

        coordination.save!
      end

      @current_account.add_step 4
      @current_account.save!
    end
  end

  def step5
    puts 'step 5'
    grants = (params['0'][:items] || [])
    grant_extensions = (params['1'][:items] || [])

    ActiveRecord::Base.transaction do
      grants.each do |entry|
        next if Grant.find_by(process_number: entry[:process_number])

        grant = Grant.new
        grant.researcher_id = current_researcher[:id]
        grant.grant_project_type_id = entry[:grant_project_type_id]
        grant.grant_participation_type_id = entry[:grant_participation_type_id]
        grant.funding_agency_id = entry[:funding_agency_id]
        grant.process_number = entry[:process_number]
        grant.value_BRL = entry[:value_brl]
        grant.value_USD = entry[:value_usd]
        grant.validity_start = entry[:validity_start]
        grant.validity_end = entry[:validity_end]

        grant.submission_id = current_submission[:id]

        grant.save!
      end

      grant_extensions.each do |entry|
        extension = GrantExtension.new
        extension.grant_id = entry[:grant_id]
        extension.value_BRL = entry[:value_brl]
        extension.value_USD = entry[:value_usd]
        extension.validity_start = entry[:validity_start]
        extension.validity_end = entry[:validity_end]

        extension.submission_id = current_submission[:id]

        extension.save!
      end

      @current_account.add_step 5
      @current_account.save!
    end
  end

  def step6
    puts 'step 6'
    activities = (params['0'][:items] || [])

    ActiveRecord::Base.transaction do
      activities.each do |entry|
        activity = Activity.new
        activity.description = entry[:description]
        activity.workload = entry[:workload]
        activity.duration = entry[:duration]
        activity.activity_type_id = entry[:activity_type_id]
        activity.year = CurrentYear.current_year

        activity.submission_id = current_submission[:id]

        activity.save!
      end

      @current_account.add_step 6
      @current_account.save!
    end
  end

  def step7
    puts 'step 7'
    notes = (params['0'][:items] || [])

    ActiveRecord::Base.transaction do
      notes.each do |entry|
        note = Note.new
        note.note = entry[:note]
        note.year = CurrentYear.current_year

        note.submission_id = current_submission[:id]

        note.save!
      end

      @current_account.add_step 6
      @current_account.save!
    end
  end

  def current_researcher
    Researcher.find_by(employee_id: @current_account.employee_id)
  end

  def current_submission
    current_submission = Submission.find_by(account_id: @current_account[:id],
                                            date: CurrentYear.current_year)
    current_submission || Submission.create(account_id: @current_account[:id],
                                            accepted: false,
                                            date: CurrentYear.current_year,
                                            last_modified: Time.current)
  end

  def touch_submission
    current_submission[:last_modified] = Time.now
    p '=========================================================================================='
    p DateTime.now
    p current_submission
    current_submission.save!
  end

  # POST /forms/steps
  def step
    p '*******************************************************************************'
    p 'Params Received:'
    p ''
    p params
    p ''
    p 'Calling step' + params[:step].to_s
    p '*******************************************************************************'

    send('step' + params[:step].to_s)
    touch_submission

    # if there wasnt an error during the step, return ok
    render nothing: true, status: :ok
  end
end
