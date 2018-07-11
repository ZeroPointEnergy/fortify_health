require "jasper_helpers"
require "inflector"

class ApplicationController < Amber::Controller::Base
  include JasperHelpers
  LAYOUT = "application.slang"

  def current_user
    context.current_user
  end

  def signed_in?
    current_user ? true : false
  end

  private def redirect_signed_out_user
    unless signed_in?
      flash[:info] = "Must be logged in"
      redirect_to "/signin"
    end
  end

  macro get_user
    if user = context.current_user
      user
    else
      flash[:info] = "Must be logged in"
      return redirect_to "/signin"
    end
  end

  macro resolve(id, model_class)
    if result = {{model_class.id}}.find({{id}})
      result
    else
      flash["danger"] = "Could not find #{Inflector.humanize({{model_class.id}})} with id #{ {{id}} }"
      return redirect_to("/#{Inflector.pluralize(Inflector.underscore({{model_class.id}}.to_s))}")
    end
  end

end
