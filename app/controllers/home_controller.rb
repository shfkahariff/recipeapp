class HomeController < ApplicationController
  def index
  end

  def profile
  end

  #sidekiq: bundle exec sidekiq -C config/sidekiq.yml
end
