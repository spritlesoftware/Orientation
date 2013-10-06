require 'rho/rhocontroller'
require 'helpers/browser_helper'

class RotationController < Rho::RhoController
  include BrowserHelper
  
  def push_callback
      Rho::Notification.showPopup(@params['msg'])
  end
  
  def left_handed_position
    Rho::ScreenOrientation.leftHanded
    navigate_back
  end
  
  def send_push
   @device_id = Rho::System.getProperty("devicePushId")
   @server_url = {:url =>"http://192.168.1.105:3000/api/push?input=#{@device_id}" }
   Rho::Network.get(@server_url)
   redirect :action => :index
  end

  
  def right_handed_position
    Rho::ScreenOrientation.rightHanded
    navigate_back
  end
  
  def upside_down_position
    Rho::ScreenOrientation.upsideDown
    navigate_back
  end
  
  def navigate_back
    Rho::WebView.navigateBack
  end

  # GET /Rotation
  def index
    @rotations = Rotation.find(:all)
    render :back => '/app'
  end

  # GET /Rotation/{1}
  def show
    @rotation = Rotation.find(@params['id'])
    if @rotation
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Rotation/new
  def new
    @rotation = Rotation.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Rotation/{1}/edit
  def edit
    @rotation = Rotation.find(@params['id'])
    if @rotation
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Rotation/create
  def create
    @rotation = Rotation.create(@params['rotation'])
    redirect :action => :index
  end

  # POST /Rotation/{1}/update
  def update
    @rotation = Rotation.find(@params['id'])
    @rotation.update_attributes(@params['rotation']) if @rotation
    redirect :action => :index
  end

  # POST /Rotation/{1}/delete
  def delete
    @rotation = Rotation.find(@params['id'])
    @rotation.destroy if @rotation
    redirect :action => :index  
  end
end
