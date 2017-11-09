require "yast"
require "cwm"

module Y2Firewall
  module Widgets
    class OpenService < CWM::CustomWidget
      def initialize(settings = nil)
        textdomain "firewall"

        @settings = settings || default_settings
      end

      def contents
        return VBox(Empty()) if !@settings[:services]

        VBox(
          Frame(
            _("Firewall Settings for %{firewall}") % { firewall: 'ssh' },
            VBox(
              Left(
                HBox(
                  OpenFirewall.new(@settings),
                  HSpacing(2),
                  Details.new(@settings)
                )
              ),
              Left(
                ReplacePoint(
                  Id(:_cwm_firewall_status_rp),
                  Label(_("Firewall is open"))
                )
              )
            )
          )
        )
      end

      def handle(event)
        Yast::Popup.Error("El evento es #{event}")
      end

    private
      def default_settings
        {
          open_firewall_checkbox: false
        }
      end
    end


    class OpenFirewall < CWM::CheckBox
      def initialize(settings)
        @settings = settings
      end

      def options
        [:notify]
      end

      def label
        @settings.fetch("open_firewall_checkbox", _("Open Port in &Firewall"))
      end

      def init
        self.value = @settings.fetch("open_firewall_checkbox", false)
      end
    end

    class Details < CWM::PushButton
      def initialize(settings)
        @settings = settings
      end

      def label
        @settings.fetch("firewall_details_button", _("Firewall &Details..."))
      end

      def handle
      end
    end
  end
end
