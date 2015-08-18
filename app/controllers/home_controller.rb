class HomeController < ApplicationController
  include SuppressMenuButton

  def show
    @article = Core::HomePageReader.new('the-money-advice-service').call
  end

  def display_skip_to_main_navigation?
    false
  end

  def contact_panels_homepage?
    true
  end
end
