# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  class AccessForbidden < StandardError; end

  included do
    before_action :authorize

    rescue_from Authorization::AccessForbidden, with: :four_zero_three

    def authorize
      auth = AuthorizeApiRequest.new(request.headers).call
      Current.user = auth[:user]
    end

    def owner?(object, &block)
      return true if block.call(object)

      raise(Authorization::AccessForbidden, 'Access denied. No access to resource.')
    end
  end

  def four_zero_three(e)
    json_response({ message: e.message }, :forbidden)
  end

end
