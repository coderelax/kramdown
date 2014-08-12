module Kramdown

  module Converter

    class Vop < Html

      def initialize(root, options)
        super
      end

      def convert(el, indent = -@indent)
        # el.children.each {|child| binding.pry if child.options[:location] == 8}
        super
      end

      def convert_li(el, indent)
        "<li class='answer'>#{el.value}</li>"
      end

      def convert_raw(el, indent)
        el.value
      end

    end

  end

end
