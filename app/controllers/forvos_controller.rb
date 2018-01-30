require 'pry'
require_dependency '../../lib/api_wrapper'


class ForvosController < ApplicationController
  def forvo
    audio_files = ApiWrapper.forvo(params[:translated])

    render(
      json: audio_files,
      status: :ok
    )
  end

  private

  def forvo_params
    params.require(:forvo).permit(:translated)
  end
end
