class EmployeeService

  def self.create_employee(params)
    employee = Employee.new
    employee.name = params[:name]
    employee.is_foundation = true
    employee.laboratory_id = params[:laboratory_id]
    employee.role_foundation_level_id = params[:role_foundation_level_id]
    employee.title_id = params[:title_id]

    employee.save!
    employee
  end

end
