class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  PER_PAGE = 10
end
