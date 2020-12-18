# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_13_014454) do

  create_table "accounts", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.integer "profile_id"
    t.integer "employee_id"
    t.text "completed_steps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_accounts_on_employee_id"
    t.index ["profile_id"], name: "index_accounts_on_profile_id"
  end

  create_table "accreditations", force: :cascade do |t|
    t.integer "researcher_id"
    t.integer "postgraduate_program_id"
    t.integer "institution_id"
    t.integer "course_degree_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["course_degree_id"], name: "index_accreditations_on_course_degree_id"
    t.index ["institution_id"], name: "index_accreditations_on_institution_id"
    t.index ["postgraduate_program_id"], name: "index_accreditations_on_postgraduate_program_id"
    t.index ["researcher_id"], name: "index_accreditations_on_researcher_id"
    t.index ["submission_id"], name: "index_accreditations_on_submission_id"
  end

  create_table "activities", force: :cascade do |t|
    t.string "description"
    t.integer "workload"
    t.integer "duration"
    t.integer "activity_type_id"
    t.integer "sub_activity_type_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["activity_type_id"], name: "index_activities_on_activity_type_id"
    t.index ["sub_activity_type_id"], name: "index_activities_on_sub_activity_type_id"
    t.index ["submission_id"], name: "index_activities_on_submission_id"
  end

  create_table "activity_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "advisement_degrees", force: :cascade do |t|
    t.string "degree"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "advisements", force: :cascade do |t|
    t.integer "advisement_degree_id"
    t.integer "researcher_id"
    t.integer "intern_id"
    t.boolean "supervisor_is_postdoc"
    t.integer "postdoc_id"
    t.date "validity_start"
    t.string "validity_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.string "postdoc_name"
    t.index ["advisement_degree_id"], name: "index_advisements_on_advisement_degree_id"
    t.index ["intern_id"], name: "index_advisements_on_intern_id"
    t.index ["postdoc_id"], name: "index_advisements_on_postdoc_id"
    t.index ["researcher_id"], name: "index_advisements_on_researcher_id"
    t.index ["submission_id"], name: "index_advisements_on_submission_id"
  end

  create_table "approval_actions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "approval_histories", force: :cascade do |t|
    t.integer "account_id"
    t.integer "submission_id"
    t.integer "approval_action_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_approval_histories_on_account_id"
    t.index ["approval_action_id"], name: "index_approval_histories_on_approval_action_id"
    t.index ["submission_id"], name: "index_approval_histories_on_submission_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "DOI_url"
    t.string "reference"
    t.integer "qualis_id"
    t.float "impact_factor"
    t.integer "collaboration_type_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["collaboration_type_id"], name: "index_articles_on_collaboration_type_id"
    t.index ["qualis_id"], name: "index_articles_on_qualis_id"
    t.index ["submission_id"], name: "index_articles_on_submission_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "DOI_url"
    t.string "ISBN"
    t.integer "qualis_id"
    t.float "impact_factor"
    t.integer "collaboration_type_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["collaboration_type_id"], name: "index_books_on_collaboration_type_id"
    t.index ["qualis_id"], name: "index_books_on_qualis_id"
    t.index ["submission_id"], name: "index_books_on_submission_id"
  end

  create_table "capes_concepts", force: :cascade do |t|
    t.string "concept"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collaboration_types", force: :cascade do |t|
    t.string "collaboration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "congress_participations", force: :cascade do |t|
    t.integer "researcher_id"
    t.integer "congress_id"
    t.date "year"
    t.integer "congress_role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["congress_id"], name: "index_congress_participations_on_congress_id"
    t.index ["congress_role_id"], name: "index_congress_participations_on_congress_role_id"
    t.index ["researcher_id"], name: "index_congress_participations_on_researcher_id"
    t.index ["submission_id"], name: "index_congress_participations_on_submission_id"
  end

  create_table "congress_roles", force: :cascade do |t|
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "congresses", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["submission_id"], name: "index_congresses_on_submission_id"
  end

  create_table "coordination_degrees", force: :cascade do |t|
    t.string "degree"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_classifications", force: :cascade do |t|
    t.string "classification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_coordinations", force: :cascade do |t|
    t.string "name"
    t.integer "course_classification_id"
    t.integer "coordination_degree_id"
    t.integer "workload"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["coordination_degree_id"], name: "index_course_coordinations_on_coordination_degree_id"
    t.index ["course_classification_id"], name: "index_course_coordinations_on_course_classification_id"
    t.index ["submission_id"], name: "index_course_coordinations_on_submission_id"
  end

  create_table "course_degrees", force: :cascade do |t|
    t.string "degree"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.boolean "is_foundation"
    t.integer "laboratory_id"
    t.integer "role_foundation_level_id"
    t.integer "title_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["laboratory_id"], name: "index_employees_on_laboratory_id"
    t.index ["role_foundation_level_id"], name: "index_employees_on_role_foundation_level_id"
    t.index ["submission_id"], name: "index_employees_on_submission_id"
    t.index ["title_id"], name: "index_employees_on_title_id"
  end

  create_table "fb_levels", force: :cascade do |t|
    t.string "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "funding_agencies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grant_currentnesses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grant_extensions", force: :cascade do |t|
    t.integer "grant_id"
    t.float "value_BRL"
    t.float "value_USD"
    t.date "validity_start"
    t.date "validity_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["grant_id"], name: "index_grant_extensions_on_grant_id"
    t.index ["submission_id"], name: "index_grant_extensions_on_submission_id"
  end

  create_table "grant_participation_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grant_project_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grants", force: :cascade do |t|
    t.integer "researcher_id"
    t.integer "grant_project_type_id"
    t.integer "grant_participation_type_id"
    t.integer "funding_agency_id"
    t.string "process_number"
    t.float "value_BRL"
    t.float "value_USD"
    t.date "validity_start"
    t.date "validity_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.integer "grant_currentness_id"
    t.index ["funding_agency_id"], name: "index_grants_on_funding_agency_id"
    t.index ["grant_currentness_id"], name: "index_grants_on_grant_currentness_id"
    t.index ["grant_participation_type_id"], name: "index_grants_on_grant_participation_type_id"
    t.index ["grant_project_type_id"], name: "index_grants_on_grant_project_type_id"
    t.index ["researcher_id"], name: "index_grants_on_researcher_id"
    t.index ["submission_id"], name: "index_grants_on_submission_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "intern_multiusers", force: :cascade do |t|
    t.integer "intern_id"
    t.integer "multiuser_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["intern_id"], name: "index_intern_multiusers_on_intern_id"
    t.index ["multiuser_id"], name: "index_intern_multiusers_on_multiuser_id"
  end

  create_table "interns", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["submission_id"], name: "index_interns_on_submission_id"
  end

  create_table "laboratories", force: :cascade do |t|
    t.string "name"
    t.integer "laboratory_division_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_division_id"], name: "index_laboratories_on_laboratory_division_id"
  end

  create_table "laboratory_divisions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lectures", force: :cascade do |t|
    t.string "name"
    t.integer "lecture_count"
    t.integer "workload"
    t.integer "postgraduate_program_id"
    t.integer "institution_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["institution_id"], name: "index_lectures_on_institution_id"
    t.index ["postgraduate_program_id"], name: "index_lectures_on_postgraduate_program_id"
    t.index ["submission_id"], name: "index_lectures_on_submission_id"
  end

  create_table "line_of_researches", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ministered_classes", force: :cascade do |t|
    t.integer "postgraduate_program_id"
    t.integer "institution_id"
    t.integer "subject_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["institution_id"], name: "index_ministered_classes_on_institution_id"
    t.index ["postgraduate_program_id"], name: "index_ministered_classes_on_postgraduate_program_id"
    t.index ["subject_id"], name: "index_ministered_classes_on_subject_id"
    t.index ["submission_id"], name: "index_ministered_classes_on_submission_id"
  end

  create_table "multiuser_activities", force: :cascade do |t|
    t.integer "activity_id"
    t.integer "multiuser_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_multiuser_activities_on_activity_id"
    t.index ["multiuser_id"], name: "index_multiuser_activities_on_multiuser_id"
  end

  create_table "multiuser_articles", force: :cascade do |t|
    t.integer "article_id"
    t.integer "multiuser_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_multiuser_articles_on_article_id"
    t.index ["multiuser_id"], name: "index_multiuser_articles_on_multiuser_id"
  end

  create_table "multiuser_grants", force: :cascade do |t|
    t.integer "grant_id"
    t.integer "multiuser_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grant_id"], name: "index_multiuser_grants_on_grant_id"
    t.index ["multiuser_id"], name: "index_multiuser_grants_on_multiuser_id"
  end

  create_table "multiuser_in_labs", force: :cascade do |t|
    t.integer "multiuser_id"
    t.integer "laboratory_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_multiuser_in_labs_on_laboratory_id"
    t.index ["multiuser_id"], name: "index_multiuser_in_labs_on_multiuser_id"
  end

  create_table "multiuser_subjects", force: :cascade do |t|
    t.integer "subject_id"
    t.integer "multiuser_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["multiuser_id"], name: "index_multiuser_subjects_on_multiuser_id"
    t.index ["subject_id"], name: "index_multiuser_subjects_on_subject_id"
  end

  create_table "multiuser_theses", force: :cascade do |t|
    t.integer "thesis_id"
    t.integer "multiuser_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["multiuser_id"], name: "index_multiuser_theses_on_multiuser_id"
    t.index ["thesis_id"], name: "index_multiuser_theses_on_thesis_id"
  end

  create_table "multiusers", force: :cascade do |t|
    t.string "model"
    t.string "manufacturer"
    t.string "description"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.string "note"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["submission_id"], name: "index_notes_on_submission_id"
  end

  create_table "post_doc_types", force: :cascade do |t|
    t.string "postdoc_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "postdoc_books", force: :cascade do |t|
    t.integer "book_id"
    t.integer "postdoc_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["book_id"], name: "index_postdoc_books_on_book_id"
    t.index ["postdoc_id"], name: "index_postdoc_books_on_postdoc_id"
    t.index ["submission_id"], name: "index_postdoc_books_on_submission_id"
  end

  create_table "postdoc_papers", force: :cascade do |t|
    t.integer "postdoc_id"
    t.integer "article_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["article_id"], name: "index_postdoc_papers_on_article_id"
    t.index ["postdoc_id"], name: "index_postdoc_papers_on_postdoc_id"
    t.index ["submission_id"], name: "index_postdoc_papers_on_submission_id"
  end

  create_table "postdocs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["submission_id"], name: "index_postdocs_on_submission_id"
  end

  create_table "postgraduate_programs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "productivity_grant_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "productivity_grants", force: :cascade do |t|
    t.integer "productivity_grant_type_id"
    t.boolean "is_fb"
    t.date "validity_start"
    t.date "validity_end"
    t.integer "researcher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["productivity_grant_type_id"], name: "index_productivity_grants_on_productivity_grant_type_id"
    t.index ["researcher_id"], name: "index_productivity_grants_on_researcher_id"
    t.index ["submission_id"], name: "index_productivity_grants_on_submission_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "access_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "qualis", force: :cascade do |t|
    t.string "qualis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "researcher_books", force: :cascade do |t|
    t.integer "book_id"
    t.integer "researcher_id"
    t.boolean "first_author"
    t.boolean "last_author"
    t.boolean "corresponding_author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["book_id"], name: "index_researcher_books_on_book_id"
    t.index ["researcher_id"], name: "index_researcher_books_on_researcher_id"
    t.index ["submission_id"], name: "index_researcher_books_on_submission_id"
  end

  create_table "researcher_multisers", force: :cascade do |t|
    t.integer "researcher_id"
    t.integer "multiuser_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["multiuser_id"], name: "index_researcher_multisers_on_multiuser_id"
    t.index ["researcher_id"], name: "index_researcher_multisers_on_researcher_id"
  end

  create_table "researcher_papers", force: :cascade do |t|
    t.integer "article_id"
    t.integer "researcher_id"
    t.boolean "first_author"
    t.boolean "last_author"
    t.boolean "corresponding_author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["article_id"], name: "index_researcher_papers_on_article_id"
    t.index ["researcher_id"], name: "index_researcher_papers_on_researcher_id"
    t.index ["submission_id"], name: "index_researcher_papers_on_submission_id"
  end

  create_table "researchers", force: :cascade do |t|
    t.string "researcher_id"
    t.string "ORCID"
    t.date "ingress_date"
    t.string "email"
    t.boolean "is_lab_director"
    t.string "code"
    t.integer "post_doc_type_id"
    t.integer "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_researchers_on_employee_id"
    t.index ["post_doc_type_id"], name: "index_researchers_on_post_doc_type_id"
  end

  create_table "responsible_multiusers", force: :cascade do |t|
    t.integer "researcher_id"
    t.integer "multiuser_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["multiuser_id"], name: "index_responsible_multiusers_on_multiuser_id"
    t.index ["researcher_id"], name: "index_responsible_multiusers_on_researcher_id"
  end

  create_table "role_foundation_levels", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "categories", default: "--- []\n"
  end

  create_table "scholarships", force: :cascade do |t|
    t.integer "advisement_id"
    t.integer "funding_agency_id"
    t.string "process_number"
    t.float "total_value_BRL"
    t.float "total_value_USD"
    t.float "technical_reserve_BRL"
    t.date "validity_start"
    t.date "validity_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["advisement_id"], name: "index_scholarships_on_advisement_id"
    t.index ["funding_agency_id"], name: "index_scholarships_on_funding_agency_id"
    t.index ["submission_id"], name: "index_scholarships_on_submission_id"
  end

  create_table "scientometric_indices", force: :cascade do |t|
    t.integer "citations_wos"
    t.float "h_index_wos"
    t.integer "citations_gs"
    t.float "h_index_gs"
    t.integer "researcher_id"
    t.integer "primary_line_of_research_id"
    t.integer "secondary_line_of_research_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["primary_line_of_research_id"], name: "index_scientometric_indices_on_primary_line_of_research_id"
    t.index ["researcher_id"], name: "index_scientometric_indices_on_researcher_id"
    t.index ["secondary_line_of_research_id"], name: "index_scientometric_indices_on_secondary_line_of_research_id"
    t.index ["submission_id"], name: "index_scientometric_indices_on_submission_id"
  end

  create_table "student_books", force: :cascade do |t|
    t.integer "book_id"
    t.integer "intern_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["book_id"], name: "index_student_books_on_book_id"
    t.index ["intern_id"], name: "index_student_books_on_intern_id"
    t.index ["submission_id"], name: "index_student_books_on_submission_id"
  end

  create_table "student_papers", force: :cascade do |t|
    t.integer "article_id"
    t.integer "intern_id"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["article_id"], name: "index_student_papers_on_article_id"
    t.index ["intern_id"], name: "index_student_papers_on_intern_id"
    t.index ["submission_id"], name: "index_student_papers_on_submission_id"
  end

  create_table "sub_activity_types", force: :cascade do |t|
    t.string "name"
    t.integer "activity_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_type_id"], name: "index_sub_activity_types_on_activity_type_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["submission_id"], name: "index_subjects_on_submission_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.integer "account_id"
    t.boolean "accepted", default: false
    t.datetime "last_modified"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "reproved", default: false
    t.boolean "submitted", default: false
    t.index ["account_id"], name: "index_submissions_on_account_id"
  end

  create_table "supervision_types", force: :cascade do |t|
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "theses", force: :cascade do |t|
    t.date "finish_year"
    t.integer "institution_id"
    t.date "delivery_date"
    t.integer "advisement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["advisement_id"], name: "index_theses_on_advisement_id"
    t.index ["institution_id"], name: "index_theses_on_institution_id"
    t.index ["submission_id"], name: "index_theses_on_submission_id"
  end

  create_table "titles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_researcher", default: false
  end

end
