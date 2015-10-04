class EditablesController < ApplicationController
  def update
    # injection protection
    #number = /^([1-9]+)/
    #word = /^([a-z,_,-]+)/
    #params[:model]  = params[:model].match(word)[0]
    #params[:id]     = params[:id].match(number)[0]
    #params[:method] = params[:method].match(word)[0]
    #params[:value]  = params[:value].match(word)[0]

    # go
    eval("#{params[:model].camelize}.find(#{params[:id]}).update(#{params[:method]}: '#{params[:value]}')");
    if params[:display_with].length > 0
      value = ActionController::Base.helpers.send(params[:display_with], params[:value])
    else
      value = params[:value]
    end
    render json: "{\"value\":\"#{value}\"}", status: :ok
  end
end
