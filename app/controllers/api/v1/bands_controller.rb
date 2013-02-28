module Api
  module V1
    class BandsController < ApplicationController
      respond_to :json

      def index
        respond_with Band.all
      end

    end
  end
end
