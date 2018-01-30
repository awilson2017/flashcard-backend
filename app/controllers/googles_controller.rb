require_dependency '../../lib/api_wrapper'

class GooglesController < ApplicationController

  def google
    translated_word = ApiWrapper.google_translate(params[:query])

    render(
      json: translated_word,
      status: :ok
    )
  end

  private

  def google_params
    params.require(:google).permit(:query)
  end
end
