class ApplicationController < ActionController::Base
    def hello
        render html: "welcome to my sample app :)"
    end
end
