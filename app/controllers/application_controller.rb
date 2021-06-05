class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, with: :render_bad_parameters
  rescue_from ActiveRecord::AssociationTypeMismatch, with: :missing_title

  def render_bad_parameters(error)
    render json: ErrorSerializer.new(error), status: :bad_request
  end

  def missing_title
    error = "Subscription cannot be created without a title."
    render json: ErrorSerializer.new(error), status: :bad_request
  end
end
