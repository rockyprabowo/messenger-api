# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    before_action :authorize

    def authorize
      auth = AuthorizeApiRequest.new(request.headers).call
      Current.user = auth[:user]
    end
  end
end
