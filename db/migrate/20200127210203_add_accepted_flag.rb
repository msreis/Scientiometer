# frozen_string_literal: true

class AddAcceptedFlag < ActiveRecord::Migration[5.2]
  def change
    tables = %i[accreditations
                activities
                advisements
                articles
                congress_participations
                congresses
                course_coordinations
                employees
                grant_extensions
                grants
                interns
                lectures
                ministered_classes
                notes
                postdocs
                researcher_papers
                scholarships
                scientometric_indices
                student_papers
                subjects
                theses
                postdoc_papers
                researcher_books
                student_books
                postdoc_books
                books
                productivity_grants
              ]

    # Add column submission to all tables that are in a form submission from
    # a researcher
    tables.each do |table_name|
      add_reference table_name, :submission, foreign_key: { to_table: :submissions }
    end
  end
end
