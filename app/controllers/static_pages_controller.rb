class StaticPagesController < ApplicationController
$gpio_initialized = false


  def home
    @devices = Device.all
  end

  def help

  end

  def about

  end
end
