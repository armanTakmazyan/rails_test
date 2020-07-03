class EmployeesController < ApplicationController
    before_action :require_signin
    before_action :require_admin
end
