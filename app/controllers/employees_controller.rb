class EmployeesController < ApplicationController
    before_action :require_signin
    before_action :require_admin

    def index
        @employees = Employee.all.order('created_at DESC')
    end


    def new
        @employee = Employee.new
        @companies = Company.all.order('created_at DESC')
    end


    def create
        @employee = Employee.new(resume_params)
        @companies = Company.all.order('created_at DESC')
        if @employee.save
            flash.notice = "New Employee was added to the #{@employee.company.name} company: #{@employee.first_name}"
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
        @companies = Company.all.order('created_at DESC')
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
        name = Employee.find(params[:id]).first_name 
        Employee.find(params[:id]).destroy
        redirect_to employees_path, notice: "#{name} deleted." 
    end

private 
    
    def resume_params
        params.require(:employee).permit(:first_name, :last_name, :email, :phone, :company_id)
    end    

end
