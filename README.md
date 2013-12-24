### Facebook Login and Push messages demo on RhoMobile

* Code contributed by our Alumni [@Dhepthi](https://github.com/Dhepthi)
* Used **Facebook Javascript sdk** integration in to Rhodes app. 
 * Integrated Facebook login and logout button.  
 * Created Facebook application using Facebook developer site. 
 * Used appid and initialized Canvas URL/Site URL for redirection purpose in rhodes application. 
 * Exception handled in Javascript code itself by checking the authResponse object.
 * see **app/Rotation/login.erb** code for more info
* Push Service
 * Created a project in Google GCM site and saved the project number,api key for sending the push message. 
 * Enabled rhodes application with push capabilities and GCM project number in build.yml. Also enabled Notification for push service so that user will get an alert in rhodes application. 
 * Used gcm ruby gem to send message to android device. We can run the configured gcm push ruby file to send push message in rhodes android device or call a method in rails from rhodes app. 
 * Consumed Rails Push api from rhodes app with device_id parameter. Exception handled for this task is to send device id if available and check for params exists in rails side
