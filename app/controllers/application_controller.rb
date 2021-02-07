class ApplicationController < ActionController::API
  before_action :authenticate_user!

  extend ErrorException
end
