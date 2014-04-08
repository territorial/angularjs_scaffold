module Angularjs
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def init_angularjs
      
      copy_file "application.js", "app/assets/javascripts/application.js"
      
      remove_file "app/assets/stylesheets/application.css"
      @application_css_file ='app/assets/stylesheets/application.css.scss'      
      copy_file "application.css.scss", @application_css_file
      
      directory "underscore", "app/assets/javascripts/underscore/"
      directory "angularjs", "app/assets/javascripts/angularjs/"
      directory "angular-libs", "app/assets/javascripts/angular-libs/"
      directory "app", "app/assets/javascripts/app/"
      
    end

    def init_twitter_bootstrap_assets
      unless options["no-bootstrap"]
        directory "bootstrap/", "app/assets/javascripts/bootstrap/"      
      end
    end

    attr_reader :app_name, :container_class, :language
    def init_twitter_bootstrap_layout
      @app_name = Rails.application.class.parent_name
      @container_class = options["layout-type"] == "fluid" ? "container-fluid" : "container"
      @language = "coffeescript"
      template "application.html.erb", "app/views/layouts/application.html.erb"
    end

    def generate_welcome_controller
      remove_file "public/index.html"
      empty_directory "app/assets/templates"
      
      if @language == 'coffeescript'
        copy_file "routes.coffee.erb", "app/assets/javascripts/app/routes.coffee.erb"
        insert_into_file "app/assets/javascripts/app/routes.coffee.erb", @app_name, before: 'Client'
        ['csrf_controller', 'session_service'].each do |file|
          copy_file "#{file}.js.coffee",
            "app/assets/javascripts/app/#{file}.js.coffee"
        end
      end

      insert_into_file "app/controllers/application_controller.rb",
        %{
          private
        
          # AngularJS automatically sends CSRF token as a header called X-XSRF
          # this makes sure rails gets it
          def verified_request?
            !protect_against_forgery? || request.get? ||
              form_authenticity_token == params[request_forgery_protection_token] ||
              form_authenticity_token == cookies['XSRF-TOKEN'] ||
              form_authenticity_token == request.headers['X-CSRF-Token'] ||
              form_authenticity_token == (request.headers['X-XSRF-Token'].chomp('"').reverse.chomp('"').reverse if request.headers['X-XSRF-Token'])
          end
         }, before: "end"

    end
  end  
end
