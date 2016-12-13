require("sinatra/activerecord")
require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/employee")
require("./lib/department")
require("pg")
require('pry-nav')

get('/') do
  erb(:index)
end

get('/departments') do
  @departments = Department.all
  erb(:departments)
end

get('/employees') do
  @employees = Employee.all
  @departments = Department.all
  erb(:employees)
end

post('/employees') do
  name = params['name']
  department = params['departments'].to_i
  @employee = Employee.new(:name => name, :department_id => department)
  @employee.save
  @employees= Employee.all
  @departments = Department.all
  erb(:employees)
end

delete('/employees') do
  @employee = Employee.find(params.fetch('id').to_i)
  @employee.delete
  @employees = Employee.all
  @departments = Department.all
  erb(:employees)
end

post('/departments') do
  name = params['name']
  @department = Department.new(:name => name)
  @department.save
  @departments= Department.all
  erb(:departments)
end

delete('/departments') do
  @department = Department.find(params.fetch('id').to_i)
  @department.delete
  @departments = Department.all
  erb(:departments)
end

get('/department/:id/edit') do
  @department = Department.find(params['id'].to_i)
  @employees = @department.employees
  erb(:department)
end

patch('/department/:id') do
  name = params["name"]
  @department = Department.find(params.fetch('id').to_i)
  @department.update({:name => name})
  @departments = Department.all()
  erb(:departments)
end
