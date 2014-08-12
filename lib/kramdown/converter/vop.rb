module Kramdown

  module Converter

    class Vop < Html

      def convert(el, indent = -@indent)
        super
      end

      # TODO: I was doing a few changes here but they don't seem to be needed any more.
      def convert_li(el, indent)
        super
      end

      def convert_raw(el, indent)
        super
      end

    end

  end

end
