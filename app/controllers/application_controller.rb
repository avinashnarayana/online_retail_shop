class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper
    
    private
      # Confirms a logged-in user.
      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end
      
      # Confirms shopkeeper.
      def shopkeeper
        unless !!current_user && current_user.role == 1
          store_location
          flash[:danger] = "Please log in as a shopkeeper to access the page."
          redirect_to login_url
        end
      end
      
      # Confirms shopkeeper.
      def shopassistant
        unless !!current_user && current_user.role > 0
          store_location
          flash[:danger] = "Please log in as a shopkeeper/shopassistant to access the page."
          redirect_to login_url
        end
      end
end
