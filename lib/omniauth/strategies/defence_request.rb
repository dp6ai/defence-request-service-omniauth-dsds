require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class DefenceRequest < OmniAuth::Strategies::OAuth2
      option :name, "defence_request"

      option :client_options, {
        site: ENV.fetch('AUTHENTICATION_SITE_URL'),
        redirect_url: ENV.fetch('AUTHENTICATION_REDIRECT_URI')
      }

      uid { user_info["id"] }

      info do
        {
          username: user_info["username"],
          email: user_info["email"],
          profile: profile,
          roles: roles,
        }
      end

      extra do
        {
          raw_info: raw_info,
        }
      end

      def raw_info
        @_raw_info ||= MultiJson.decode access_token.get("/api/v1/me").body
      end

      private

      def user_info
        raw_info["user"]
      end

      def profile
        raw_info["profile"]
      end

      def roles
        raw_info["roles"]
      end
    end
  end
end
