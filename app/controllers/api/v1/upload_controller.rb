class Api::V1::UploadController < ApplicationController
  def create
    if valid_verse?
      render_verse(verse_params, params[:audio])
    elsif verse_no_title?
      render_title_error
    elsif verse_bad_ids?
      render_verse_bad_ids
    elsif valid_competition?
      render_valid_competition(competition_params, params[:audio])
    elsif invalid_competition?
      render_invalid_competition(competition_params)
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
    params[:type] == 'verse' && valid_ids? && params[:title]
  end

  def verse_no_title?
    params[:type] == 'verse' && valid_ids?
  end

  def verse_bad_ids?
    params[:type] == 'verse'
  end

  def valid_competition?
    valid_month? && valid_year? && valid_description? && valid_genre? && valid_rules? && valid_image? && valid_title? && params[:type] == 'competition'  # && user == admin
  end

  def valid_month?
    (1..12).to_a.include?(params[:month].to_i)
  end

  def valid_year?
    params[:year].present?
  end

  def valid_description?
    params[:description].present?
  end

  def valid_genre?
    params[:genre].present?
  end

  def valid_rules?
    params[:rules].present?
  end

  def valid_image?
    params[:image].present?
  end

  def valid_title?
    params[:title].present?
  end

  def invalid_competition?
    params[:type] == 'competition'
  end

  def verse_params
    params.permit(:user_id, :competition_id, :title)
  end

  def competition_params
    params.permit(:month, :year, :description, :genre, :rules, :image, :title)
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

  def render_title_error
    output = Hash.new
    output[:error] = 'Title parameter is required for verse upload.'

    render json: output, :status => 400
  end

  def render_verse_bad_ids
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

  def render_invalid_competition(competition_params)
    missing_params = find_missing_parameters(competition_params)

    output = Hash.new
    if missing_params.length == 1
      output[:error] = "#{missing_params[0].capitalize} parameter must be included for competition upload requests."
    else
      output[:error] = "#{missing_params.join(', ').capitalize} parameters must be included for competition upload requests."
    end

    render json: output, :status => 400
  end

  def find_missing_parameters(competition_params)
    missing_params = []
    missing_params << 'month' unless competition_params[:month]
    missing_params << 'year' unless competition_params[:year]
    missing_params << 'genre' unless competition_params[:genre]
    missing_params << 'rules' unless competition_params[:rules]
    missing_params << 'image' unless competition_params[:image]
    missing_params << 'title' unless competition_params[:title]
    missing_params << 'description' unless competition_params[:description]
  end

  def render_invalid_type
    output = Hash.new
    output[:error] = 'Invalid type.'

    render json: output, :status => 400
  end
end
