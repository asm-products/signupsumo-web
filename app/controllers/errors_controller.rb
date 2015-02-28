class ErrorsController < ApplicationController
  def file_not_found
    render 'exception'
  end

  def unprocessable
    render 'exception'
  end

  def internal_server_error
    render 'exception'
  end
end
