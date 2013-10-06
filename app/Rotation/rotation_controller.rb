require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'
class RotationController < Rho::RhoController
  include BrowserHelper
  
  def push_callback
      Rho::Notification.showPopup(@params['msg'])
      redirect :action => :index
  end
  
  def left_handed_position
    Rho::ScreenOrientation.leftHanded
    navigate_back
  end
  
  def send_push
   @device_id = Rho::System.getProperty("devicePushId")
   @server_url = {:url => Rho::RhoConfig.RHO_PUSH_SERVER_URL + @device_id }
   Rho::Network.get(@server_url)
   render :action => :wait
  end
  
  def login
    refresh_app
    @rotation = Rotation.new
    render
  end
  
  def call_reverse_web_service
     @hash_params =  {:url => Rho::RhoConfig.RHO_REVERSE_SERVER_URL + Rho::RhoSupport.url_encode(@params['rotation']['input'])}
      Rho::Network.get(@hash_params,url_for(:action => :reverse_callback))
     render :action => :wait
  end
  
  def reverse_callback
    if @params["status"] != "error"
      data = Rho::JSON.parse(@params["body"])
      @reverse_string = data["response"]["reversed_sentence"]
      Rho::WebView.navigate( url_for :action => :tasks, :query => { :msg => @reverse_string } )
     else
       Rho::Notification.showPopup("The system is unable to process your request at this time")
     end
  end
  
  def right_handed_position
    Rho::ScreenOrientation.rightHanded
    navigate_back
  end
  
  def upside_down_position
    Rho::ScreenOrientation.upsideDown
    navigate_back
  end
  def refresh_app
    Rho::WebView.refresh
  end
  def navigate_back
    redirect :action => :index
  end

  # GET /Rotation
  def index
    refresh_app
    render
  end
  
  def tasks
    @data = @params["msg"]
    render
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
