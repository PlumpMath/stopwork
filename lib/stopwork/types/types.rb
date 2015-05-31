require "mustache"
require_relative "../Stopwork"

module Stopwork
  module Types
    class <<self
      attr_accessor :match_order
    end

    # Basic slide
    # 
    # Slides consist of unprocessed slide content. Normally not used except as
    # a basis for other slide types.
    class Slide < Mustache
      attr_reader :slide
      def initialize slide, slideshow
        @slide = slide
        @slideshow = slideshow
      end

      def self.match? slide
        true
      end

      def template
        "<div class='slide'>{{slide}}</div>"
      end
    end
  end
end

require_relative "text"
require_relative "image"
require_relative "cloudapp"
require_relative "imgur"
require_relative "web"
require_relative "video"

module Stopwork
  module Types
    self.match_order = [Imgur, CloudApp, Image, Video, Web, Text]

    def self.render slide, slideshow
      self.match_order.select { |f| f.match? slide }.first.new(slide, slideshow).render # TODO optimize
    end
  end
end