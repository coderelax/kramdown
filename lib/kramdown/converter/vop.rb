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

      # FIXME: ul showing with no items
      def convert_li(el, indent)
        output = "<li class='answer'>"
        output << "#{convert_raw(el.children.first, indent)}"
        output << "</li>"
        binding.pry
        # el.value
        output
      end

      def convert_raw(el, indent)
        binding.pry
        el.value
      end

    end

  end

end
