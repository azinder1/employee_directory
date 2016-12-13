class CreateDepartments < ActiveRecord::Migration[5.0]
  def change
   create_table(:departments) do |t|
     t.column(:name, :string)

     t.timestamps()
   end

   add_column(:employees, :department_id, :integer)
 end
end
