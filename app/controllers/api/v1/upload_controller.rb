class Api::V1::UploadController < ApplicationController
  def create
    if valid_verse?
      render_verse(verse_params, params[:audio])
    elsif invalid_verse?
      render_invalid_verse
    elsif valid_competition?
      render_valid_competition(competition_params, params[:audio])
    elsif invalid_competition?
      render_invalid_competition
    else
      render_invalid_type
    end
  end

  private

  def valid_ids?
    user = User.where(id: params[:user_id])
    competition = Competition.where(id: params[:competition_id])
    user != [] && competition != []
  end

  def valid_verse?
    params[:type] == 'verse' && valid_ids?
  end

  def invalid_verse?
    params[:type] == 'verse'
  end

  def valid_competition?
    (1..12).to_a.include?(params[:month].to_i) && params[:year].present? && params[:type] == 'competition'  # && user == admin
  end

  def invalid_competition?
    params[:type] == 'competition'
  end

  def verse_params
    params.permit(:user_id, :competition_id, :title)
  end

  def competition_params
    params.permit(:month, :year, :description, :genre, :rules)
  end

  def has_error?(output)
    output.class == Hash
  end

  def render_verse(verse_params, audio)
    output = VerseFacade.create_verse(verse_params, audio)

    if has_error?(output)
      render json: output, :status => 500
    else
      verse_output = VerseSerializer.new(output)
      render json: verse_output
    end
  end

  def render_invalid_verse
    output = Hash.new
    output[:error] = 'Invalid user or competition id.'

    render json: output, :status => 400
  end

  def render_valid_competition(competition_params, audio)
    output = CompetitionFacade.create_competition(competition_params, audio)

    if has_error?(output)
      render json: output, :status => 500
    else
      competition_output = CompetitionSerializer.new(output)
      render json: competition_output
    end
  end

  def render_invalid_competition
    output = Hash.new
    output[:error] = 'Month and year must be included and valid in competition upload requests.'

    render json: output, :status => 400
  end

  def render_invalid_type
    output = Hash.new
    output[:error] = 'Invalid type.'

    render json: output, :status => 400
  end
end
