class WelcomeController < ApplicationController
  before_action :authenticate_admin!, except: [:index]
  def index
  end

  def backroom
  end
end
