# frozen_string_literal: true

##############################################################################
################   GET DATA FROM GIVEN SUBMISSION   ##########################
##############################################################################
class StepsDataController < ApplicationController
  before_action :authorize_request

  def get_step
    if params[:submission]
      if (@current_access_level >= 2) ||
         (Submission.find(params[:submission])[:account_id] == @current_account[:id])
        send('get_step' + params[:step].to_s)
      end
    end
  end

  def current_submission
    if params[:submission]
      Submission.find(params[:submission])
    else
      Submission.find_by(account_id: @current_account[:id],
                         date: CurrentYear.current_year)
    end
  end

  def current_researcher
    acc = Account.find(current_submission[:account_id])
    Researcher.find_by(employee_id: acc.employee_id)
  end

  def get_step1
    researcher = current_researcher
    acc = Account.find(current_submission[:account_id])
    employee = Employee.find(acc[:employee_id])

    return_package = []
    return_package << {}
    return_package[0][:name] = employee.name
    return_package[0][:role_foundation_level_id] = employee.role_foundation_level_id
    return_package[0][:title_id] = employee.title_id
    return_package[0][:laboratory_id] = employee.laboratory_id
    return_package[0][:post_doc_type_id] = researcher.post_doc_type_id
    return_package[0][:researcher_id] = researcher.researcher_id
    return_package[0][:orcid] = researcher.ORCID
    return_package[0][:email] = researcher.email
    return_package[0][:ingress_date] = researcher.ingress_date

    render json: return_package
  end

  def get_step2
    return_package = []

    current_employee = Employee.find(@current_account[:employee_id])

    # State Employees
    state_employees = Employee.where(
      submission_id: current_submission[:id],
      is_foundation: false
    )

    state_employees_ret = []
    state_employees&.each do |employee|
      entry = {}
      entry[:id] = employee.id
      entry[:name] = employee.name
      entry[:role_foundation_level_id] = employee.role_foundation_level_id
      entry[:role_foundation_level_description] = RoleFoundationLevel.find(employee.role_foundation_level_id).description
      current_employee[:laboratory_id] = employee.laboratory_id
      entry[:title_id] = employee.title_id
      entry[:title_name] = Title.find(employee.title_id).name
      current_submission[:id] = employee.submission_id
      state_employees_ret << entry
    end

    return_package << { items: state_employees_ret }

    # Foundation Employees
    found_employees = Employee.where(
      submission_id: current_submission[:id],
      is_foundation: true
    )

    found_employees_ret = []
    found_employees&.each do |employee|
      entry = {}
      entry[:id] = employee.id
      entry[:name] = employee.name
      entry[:role_foundation_level_id] = employee.role_foundation_level_id
      entry[:role_foundation_level_description] = RoleFoundationLevel.find(employee.role_foundation_level_id).description
      current_employee[:laboratory_id] = employee.laboratory_id
      entry[:title_id] = employee.title_id
      entry[:title_name] = Title.find(employee.title_id).name
      current_submission[:id] = employee.submission_id
      found_employees_ret << entry
    end

    return_package << { items: found_employees_ret }

    # Students
    students = Advisement.where(
      submission_id: current_submission[:id]
    )

    students_ret = []
    students&.each do |advisement|
      entry = {}
      intern = Intern.find(advisement[:intern_id])
      entry[:name] = intern.name
      entry[:id] = intern.id

      entry[:advisement_degree] = {}
      entry[:advisement_degree][:value] = advisement.advisement_degree_id
      entry[:advisement_degree][:text] = AdvisementDegree.find(advisement.advisement_degree_id).degree
      entry[:postdoc] = advisement.supervisor_is_postdoc
      entry[:postdoc_name] = advisement.postdoc_name
      entry[:validity_start] = advisement.validity_start
      entry[:validity_end] = advisement.validity_end

      scholarships = Scholarship.where(
        advisement_id: advisement[:id]
      )
      # Student scholarships
      scholarships_ret = []
      scholarships.each do |scholarship|
        ship_entry = {}
        ship_entry[:funding_agency_id] = scholarship.funding_agency_id
        ship_entry[:funding_agency_name] = FundingAgency.find(scholarship.funding_agency_id).name
        ship_entry[:process_number] = scholarship.process_number
        ship_entry[:value_BRL] = scholarship.total_value_BRL
        ship_entry[:value_USD] = scholarship.total_value_USD
        ship_entry[:technical_reserve_BRL] = scholarship.technical_reserve_BRL
        ship_entry[:validity_start] = scholarship.validity_start
        ship_entry[:validity_end] = scholarship.validity_end
        scholarships_ret << ship_entry
      end
      entry[:scholarships] = scholarships_ret
      entry[:nScholarships] = scholarships_ret.size

      students_ret << entry
    end

    return_package << { items: students_ret }

    prod_grants = ProductivityGrant.where(
      submission_id: current_submission[:id]
    )

    prod_grants_ret = []
    prod_grants&.each do |grant|
      entry = {}
      entry[:productivity_grant_type] = {}
      entry[:productivity_grant_type][:value] = grant.productivity_grant_type_id
      entry[:productivity_grant_type][:text] = ProductivityGrantType.find(grant.productivity_grant_type_id).name
      entry[:is_fb] = grant.is_fb
      entry[:validity_start] = grant.validity_start
      entry[:validity_end] = grant.validity_end
      entry[:researcher_id] = grant.researcher_id

      prod_grants_ret << entry
    end

    return_package << { items: prod_grants_ret }

    render json: return_package
  end

  def get_step3
    return_package = []

    papers = Article.where(
      submission_id: current_submission[:id]
    )
    papers_ret = []
    papers.each do |paper|
      entry = {}
      entry[:doi] = paper.DOI_url
      entry[:qualis] = {}
      entry[:qualis][:value] = paper.qualis_id
      entry[:impact_factor] = paper.impact_factor
      entry[:collaboration_type] = {}
      entry[:collaboration_type][:value] = paper.collaboration_type_id

      participation = ResearcherPaper.where(
        article_id: paper[:id],
        submission_id: current_submission[:id]
      )[0]
      entry[:first_author] = participation&.first_author
      entry[:last_author] = participation&.last_author
      entry[:corresponding_author] = participation&.corresponding_author

      entry[:postdoc] = []
      post_doc_degree = AdvisementDegree.find_by(degree: 'Pós-doutorado')
      post_doc_adv = Advisement.where(advisement_degree_id: post_doc_degree[:id], submission_id: current_submission[:id])
      postdocs = StudentPaper.where(
        intern_id: post_doc_adv.map { |adv| adv[:intern_id] },
        article_id: paper[:id],
        submission_id: current_submission[:id]
      )
      postdocs.each do |pd_paper|
        pd = {}
        pd[:value] = pd_paper.intern_id
        pd[:text] = Intern.find(pd_paper.intern_id).name
        entry[:postdoc] << pd
      end

      entry[:phd] = []
      phd_degree = AdvisementDegree.find_by(degree: 'Doutorado')
      phd_adv = Advisement.where(advisement_degree_id: phd_degree[:id], submission_id: current_submission[:id])
      phds = StudentPaper.where(
        intern_id: phd_adv.map { |adv| adv[:intern_id] },
        article_id: paper[:id],
        submission_id: current_submission[:id]
      )
      phds.each do |std_paper|
        phd = {}
        phd[:value] = std_paper.intern_id
        phd[:text] = Intern.find(std_paper.intern_id).name
        entry[:phd] << phd
      end

      entry[:msc] = []
      msc_degree = AdvisementDegree.find_by(degree: 'Mestrado')
      msc_adv = Advisement.where(advisement_degree_id: msc_degree[:id], submission_id: current_submission[:id])
      mscs = StudentPaper.where(
        intern_id: msc_adv.map { |adv| adv[:intern_id] },
        article_id: paper[:id],
        submission_id: current_submission[:id]
      )
      mscs.each do |std_paper|
        msc = {}
        msc[:value] = std_paper.intern_id
        msc[:text] = Intern.find(std_paper.intern_id).name
        entry[:msc] << msc
      end

      entry[:ic] = []
      ic_degree = AdvisementDegree.find_by(degree: 'Iniciação Científica')
      ic_adv = Advisement.where(advisement_degree_id: ic_degree[:id], submission_id: current_submission[:id])
      ics = StudentPaper.where(
        intern_id: ic_adv.map { |adv| adv[:intern_id] },
        article_id: paper[:id],
        submission_id: current_submission[:id]
      )
      ics.each do |std_paper|
        ic = {}
        ic[:value] = std_paper.intern_id
        ic[:text] = Intern.find(std_paper.intern_id).name
        entry[:ic] << ic
      end
      papers_ret << entry
    end
    return_package << { items: papers_ret }

    # >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    books = Book.where(
      submission_id: current_submission[:id]
    )
    books_ret = []
    books.each do |book|
      entry = {}
      entry[:doi] = book.DOI_url
      entry[:isbn] = book.ISBN
      entry[:qualis] = {}
      entry[:qualis][:value] = book.qualis_id
      entry[:impact_factor] = book.impact_factor
      entry[:collaboration_type] = {}
      entry[:collaboration_type][:value] = book.collaboration_type_id

      participation = ResearcherBook.where(
        book_id: book[:id],
        submission_id: current_submission[:id]
      )[0]
      entry[:first_author] = participation&.first_author
      entry[:last_author] = participation&.last_author
      entry[:corresponding_author] = participation&.corresponding_author

      entry[:postdoc] = []
      post_doc_degree = AdvisementDegree.find_by(degree: 'Pós-doutorado')
      post_doc_adv = Advisement.where(advisement_degree_id: post_doc_degree[:id], submission_id: current_submission[:id])
      postdocs = StudentBook.where(
        intern_id: post_doc_adv.map { |adv| adv[:intern_id] },
        book_id: book[:id],
        submission_id: current_submission[:id]
      )
      postdocs.each do |std_book|
        pd = {}
        pd[:value] = std_book.intern_id
        pd[:text] = Intern.find(std_book.intern_id).name
        entry[:postdoc] << pd
      end

      entry[:phd] = []
      phd_degree = AdvisementDegree.find_by(degree: 'Doutorado')
      phd_adv = Advisement.where(advisement_degree_id: phd_degree[:id], submission_id: current_submission[:id])
      phds = StudentBook.where(
        intern_id: phd_adv.map { |adv| adv[:intern_id] },
        book_id: book[:id],
        submission_id: current_submission[:id]
      )
      phds.each do |std_book|
        phd = {}
        phd[:value] = std_book.intern_id
        phd[:text] = Intern.find(std_book.intern_id).name
        entry[:phd] << phd
      end

      entry[:msc] = []
      msc_degree = AdvisementDegree.find_by(degree: 'Mestrado')
      msc_adv = Advisement.where(advisement_degree_id: msc_degree[:id], submission_id: current_submission[:id])

      mscs = StudentBook.where(
        intern_id: msc_adv.map { |adv| adv[:intern_id] },
        book_id: book[:id],
        submission_id: current_submission[:id]
      )
      mscs.each do |std_book|
        msc = {}
        msc[:value] = std_book.intern_id
        msc[:text] = Intern.find(std_book.intern_id).name
        entry[:msc] << msc
      end

      entry[:ic] = []
      ic_degree = AdvisementDegree.find_by(degree: 'Iniciação Científica')
      ic_adv = Advisement.where(advisement_degree_id: ic_degree[:id], submission_id: current_submission[:id])
      ics = StudentBook.where(
        intern_id: ic_adv.map { |adv| adv[:intern_id] },
        book_id: book[:id],
        submission_id: current_submission[:id]
      )
      ics.each do |std_book|
        ic = {}
        ic[:value] = std_book.intern_id
        ic[:text] = Intern.find(std_book.intern_id).name
        entry[:ic] << ic
      end
      books_ret << entry
    end
    return_package << { items: books_ret }

    index = ScientometricIndex.find_by(
      submission_id: current_submission[:id]
    )
    indices = {}
    indices[:citations_wos] = index&.citations_wos
    indices[:citations_gs] = index&.citations_gs
    indices[:h_index_gs] = index&.h_index_gs
    indices[:h_index_wos] = index&.h_index_wos
    indices[:primary_line_of_research_id] = index&.primary_line_of_research_id
    indices[:secondary_line_of_research_id] = index&.secondary_line_of_research_id
    return_package << indices

    congresses = CongressParticipation.where(
      submission_id: current_submission[:id]
    )
    congresses_ret = []
    congresses.each do |participation|
      entry = {}
      entry[:congress_role_id] = participation.congress_role_id
      entry[:role] = CongressRole.find(participation.congress_role_id).role
      congress = Congress.find(participation.congress_id)
      entry[:name] = congress.name
      entry[:country] = congress.country
      congresses_ret << entry
    end
    return_package << { items: congresses_ret }

    render json: return_package
  end

  def get_step4
    return_package = []

    theses = Thesis.where(
      submission_id: current_submission[:id]
    )
    theses_ret = []
    theses.each do |thesis|
      entry = {}
      entry[:institution] = {}
      entry[:institution][:value] = thesis.institution_id
      entry[:institution][:text] = Institution.find(thesis.institution_id).name
      entry[:delivery_date] = thesis.delivery_date
      entry[:advisement] = {}
      entry[:advisement][:value] = thesis.advisement_id
      advisement = Advisement.find(thesis.advisement_id)
      entry[:name] = Intern.find(advisement.intern_id).name
      theses_ret << entry
    end
    return_package << { items: theses_ret }

    accreditations = Accreditation.where(
      submission_id: current_submission[:id]
    )
    accreditation_ret = []
    accreditations.each do |accreditation|
      entry = {}
      entry[:postgraduate_program] = {}
      entry[:postgraduate_program][:value] = accreditation.postgraduate_program_id
      entry[:name] = PostgraduateProgram.find(accreditation.postgraduate_program_id).name
      entry[:institution] = {}
      entry[:institution][:value] = accreditation.institution_id
      entry[:institution][:text] = Institution.find(accreditation.institution_id).name
      entry[:degree] = {}
      entry[:degree][:value] = accreditation.course_degree_id
      entry[:degree][:text] = CourseDegree.find(accreditation.course_degree_id).degree
      accreditation_ret << entry
    end
    return_package << { items: accreditation_ret }

    ministered_classes = MinisteredClass.where(
      submission_id: current_submission[:id]
    )
    ministered_classes_ret = []
    ministered_classes.each do |ministered|
      subject = Subject.find(ministered.subject_id)
      entry = {}
      entry[:name] = subject.name
      entry[:code] = subject.code
      entry[:postgraduate_program_id] = ministered.postgraduate_program_id
      entry[:postgraduate_program_name] = PostgraduateProgram.find(ministered.postgraduate_program_id).name
      entry[:institution_id] = ministered.institution_id
      entry[:institution_name] = Institution.find(ministered.institution_id).name
      ministered_classes_ret << entry
    end
    return_package << { items: ministered_classes_ret }

    lectures = Lecture.where(
      submission_id: current_submission[:id]
    )
    lectures_ret = []
    lectures.each do |lecture|
      entry = {}
      entry[:name] = lecture.name
      entry[:lecture_count] = lecture.lecture_count
      entry[:workload] = lecture.workload
      entry[:postgraduate_program_id] = lecture.postgraduate_program_id
      entry[:postgraduate_program_name] = PostgraduateProgram.find(lecture.postgraduate_program_id).name if lecture.postgraduate_program_id
      entry[:institution_id] = lecture.institution_id
      entry[:institution_name] = Institution.find(lecture.institution_id).name
      lectures_ret << entry
    end
    return_package << { items: lectures_ret }

    coordinations = CourseCoordination.where(
      submission_id: current_submission[:id]
    )
    coordinations_ret = []
    coordinations.each do |coordination|
      entry = {}
      entry[:name] = coordination.name
      entry[:course_classification_id] = coordination.course_classification_id
      entry[:course_classification_classification] = CourseClassification.find(coordination.course_classification_id).classification
      entry[:coordination_degree_id] = coordination.coordination_degree_id
      entry[:coordination_degree_degree] = CoordinationDegree.find(coordination.coordination_degree_id).degree
      entry[:workload] = coordination.workload
      coordinations_ret << entry
    end
    return_package << { items: coordinations_ret }

    render json: return_package
  end

  def get_step5
    # A package of data from each component of the step
    return_package = []

    grants = Grant.where(
      submission_id: current_submission[:id]
    )

    grants_ret = []
    grants.each do |grant|
      entry = {}
      entry[:grant_project_type_id] = grant.grant_project_type_id
      entry[:grant_project_type_name] = GrantProjectType.find(grant.grant_project_type_id).name
      entry[:grant_participation_type_id] = grant.grant_participation_type_id
      entry[:grant_participation_type_name] = GrantParticipationType.find(grant.grant_participation_type_id).name
      entry[:funding_agency_id] = grant.funding_agency_id
      entry[:funding_agency_name] = FundingAgency.find(grant.funding_agency_id).name
      entry[:grant_currentness_id] = grant.grant_currentness_id
      entry[:grant_currentness_name] = GrantCurrentness.find(grant.grant_currentness_id).name
      entry[:process_number] = grant.process_number
      entry[:value_brl] = grant.value_BRL
      entry[:value_usd] = grant.value_USD
      entry[:validity_start] = grant.validity_start
      entry[:validity_end] = grant.validity_end
      grants_ret << entry
    end
    return_package << { items: grants_ret }

    render json: return_package
  end

  def get_step6
    activities = Activity.where(
      submission_id: current_submission[:id]
    )

    return_package = []

    activities_ret = []
    activities.each do |activity|
      entry = {}
      entry[:workload] = activity.workload
      entry[:duration] = activity.duration
      entry[:activity_type_id] = activity.activity_type_id
      entry[:activity_type_name] = ActivityType.find(activity.activity_type_id).name
      entry[:sub_activity_type_id] = activity.sub_activity_type_id
      entry[:sub_activity_type_name] = SubActivityType.find(activity.sub_activity_type_id).name

      activities_ret << entry
    end

    return_package << { items: activities_ret }

    render json: return_package
  end

  def get_step7
    notes = Note.where(
      submission_id: current_submission[:id]
    )

    return_package = []

    notes_ret = []
    notes.each do |note|
      entry = {}
      entry[:note] = note.note
      notes_ret << entry
    end

    return_package << { items: notes_ret }

    render json: return_package
  end
end
