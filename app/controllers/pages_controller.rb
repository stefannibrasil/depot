class PagesController < ApplicationController
  include HighVoltage::StaticPage

  skip_before_action :authorize
end
