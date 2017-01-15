module DevicesHelper
  require 'rpi_gpio'
  
  def gpio_setup
    puts "***entered gpio_setup routine***"
    RPi::GPIO.set_numbering :board
    #@devices.first.name
    if @devices.first != nil
      puts "***devices exist***"
      puts "#{$gpio_initialized}"
      puts "#{@devices.first.io}"
      @devices.each do |d|
        if d.io == 1
          RPi::GPIO.setup d.pin, :as => :input
        else
          RPi::GPIO.setup d.pin, :as => :output
        end
      end
    end
  end
end
