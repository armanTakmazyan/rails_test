class EmployeesController < ApplicationController
    before_action :require_signin
    before_action :require_admin

    def index
        @employees = Employee.all.order('created_at DESC')
    end


    def new
        @employee = Employee.new
    end


    def create
        @employee = Employee.new(resume_params)
        
        if @employee.save
            flash.notice = "The company #{@employee.name} has been uploaded."
            redirect_to employees_path
        else
            render :new  
        end
    end

    def show
        @employee = Employee.find(params[:id])
   end

   def edit
        @employee = Employee.find(params[:id]) 
   end


    def update
        @employee = Employee.find_by(id: params[:id])
        if @employee.update(resume_params)
            redirect_to @employee, notice: "Employee successfully updated!"
        else
            render :edit
        end
    end

    def destroy
        name = Employee.find(params[:id]).name 
        Employee.find(params[:id]).destroy
        redirect_to employees_path, notice: "#{name} deleted." 
    end

private 
    
    def resume_params
        params.require(:employee).permit(:first_name, :last_name, :email, :phone, :company)
    end    

end
