require 'kramdown/parser/kramdown'

module Kramdown

  module Parser

    class VOP < Kramdown::Parser::Kramdown

      def initialize(source, options)
        super
        @span_parsers.unshift(:question_tags)
      end

      QUESTION_TAGS_START = /\[\[\[[\s\S]*?\]\]\]/

      def parse_question_tags
        # @src is an instance of StringScanner(utils/string_scanner.rb)
        @src.pos += @src.matched_size
        # This gets wrapped in a block element (p tag) and is rendered as raw text.
        # What we need is to add a link element (a tag) so it functions as such
        @tree.children << process_questions(@src.matched)
      end
      define_parser(:question_tags, QUESTION_TAGS_START, '\[\[\[')

      private

      def process_questions(raw_content)
        # Let's get rid of the question markup
        raw_content.gsub!(/\[\[\[/,'').gsub!(/\]\]\]/,'')
        # The question and all the allowed answers need to be separated by a newline character
        splitted_raw_content = raw_content.split("\n")
        question = splitted_raw_content[0]
        answers = splitted_raw_content.slice(1..-1)
        markup = []
        markup << build_question(question)
        markup << build_answers(answers)
        return markup
      end

      # FIXME: This needs to actually create a new element.
      def build_question(question)
        return Element.new(:raw, question)
      end

      def build_answers(answers)
        ul = Element.new(:ul)
        answers.each do |answer|
          list_element = Element.new(:li)
          # Need to mark the correct answer and add the 'right' value as an attribute
          if index = answer =~ /--/
            # Right answer found
            input = "<input type='radio' value='right'>#{answer}</input>"
          else
            input = "<input type='radio'>#{answer}</input>"
          end
          list_element.children << Element.new(:raw, input)
          ul.children << list_element
        end
        return ul
      end

    end

  end

end
