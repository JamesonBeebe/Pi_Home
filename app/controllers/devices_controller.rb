class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy, :pin_high, :pin_low]
  

  require 'rpi_gpio'
  require 'serialport'
  # GET /devices
  # GET /devices.json
  helper DevicesHelper
  def index
    @devices = Device.all
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    if @device.io == 1
      RPi::GPIO.setup @device.pin, :as => :input
    else
      RPi::GPIO.setup @device.pin, :as => :output
    end

    respond_to do |format|
      if @device.save
        format.html { redirect_to static_pages_home_path, notice: 'Device was successfully created.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to static_pages_home_path, notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to static_pages_home_path, notice: 'Device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pin_high
    RPi::GPIO.set_high @device.pin
    puts "Turning pin #{@device.pin} ON"
  end

  def pin_low
    RPi::GPIO.set_low @device.pin
    puts "Turning pin #{@device.pin} OFF"
  end

  def serial_out
    puts "Entering serial_out routine"
    text = params[:serial_text]
    #puts text.class
    text = [text].pack('H*')
    text = text.unpack('C*')
    text.each_entry do |byte|
      #puts "BYTE"
      $ser.write "#{byte.chr}"
    end 
    #$ser.write "#{text.each_entry.to_s}"
    puts "Sending #{text.each_entry do |e| e.to_s end} command to UART0"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:id, :name, :description , :deviceFunction , :node_id, :io, :pin, :serial_text)
    end
end
