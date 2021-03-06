module DevicesHelper
  require 'rpi_gpio'
  require 'serialport'
  
  def gpio_setup
    puts "***entered gpio_setup routine***"
    RPi::GPIO.set_numbering :board
    #@devices.first.name
    $ser = SerialPort.new("/dev/ttyUSB0", 57600, 8, 1, SerialPort::NONE)
    if @devices.first.id != nil
      puts "***devices exist***"
      puts "#{$gpio_initialized}"
      puts "#{@devices.first.io}"
      puts "Pi initialized"
      @devices.each do |d|
        if d.io == 1
          RPi::GPIO.setup d.pin, :as => :input
        else
          RPi::GPIO.setup d.pin, :as => :output
        end
      end
      $gpio_initialized = true
    end
  end
end
