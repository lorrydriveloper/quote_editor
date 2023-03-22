# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  around_action :switch_locale

  def switch_locale(&)
    locale = extract_locale_from_accept_language_header
    I18n.with_locale(locale, &)
  end

  private

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def current_company
    @current_company ||= current_user.company if user_signed_in?
  end
  helper_method :current_company
end
