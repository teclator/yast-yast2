require "yast"
require "cwm/dialog"
require "y2firewall/widgets/open_service"

module Y2Firewall
  module Dialogs
    class OpenService < CWM::Dialog
      def initialize(settings)
        textdomain "firewall"

        @settings = settings
      end

      def title
        "POC (Firewall)"
      end

      def contents
        VBox(Widgets::OpenService.new(@settings))
      end
    end
  end
end
