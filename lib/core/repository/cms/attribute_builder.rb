module Core::Repository
  module CMS
    class AttributeBuilder
      class StripTagsParser
        include ActionView::Helpers::SanitizeHelper

        attr_reader :source

        def initialize(source)
          @source = source
          self
        end

        def to_html
          strip_tags(source).strip
        end
      end

      def self.build(response)
        attributes = response.body

        attributes['title']       = attributes['label']
        attributes['body']        = BlockComposer.new(attributes['blocks']).to_html

        # Home page banner
        attributes['heading']     = BlockComposer.new(attributes['blocks'], 'heading', StripTagsParser).to_html
        attributes['hero_image']  = BlockComposer.new(attributes['blocks'], 'hero_image', StripTagsParser).to_html
        attributes['bullet_1']    = BlockComposer.new(attributes['blocks'], 'bullet_1', StripTagsParser).to_html
        attributes['bullet_2']    = BlockComposer.new(attributes['blocks'], 'bullet_2', StripTagsParser).to_html
        attributes['bullet_3']    = BlockComposer.new(attributes['blocks'], 'bullet_3', StripTagsParser).to_html
        attributes['cta_text']    = BlockComposer.new(attributes['blocks'], 'cta_text', StripTagsParser).to_html
        attributes['cta_link']    = BlockComposer.new(attributes['blocks'], 'cta_link', StripTagsParser).to_html

        # Home page promoted tools x3
        attributes['tools'] = []

        (1..3).each do |i|
          attributes['tools'] << {
            heading: BlockComposer.new(attributes['blocks'], "tool_#{i}_heading", StripTagsParser).to_html,
            url:     BlockComposer.new(attributes['blocks'], "tool_#{i}_link", StripTagsParser).to_html,
            text:    BlockComposer.new(attributes['blocks'], "tool_#{i}_teaser", StripTagsParser).to_html
          }
        end

        # Home page promo tiles x4
        attributes['tiles'] = []

        (1..4).each do |i|
          attributes['tiles'] << {
            text:    BlockComposer.new(attributes['blocks'], "tile#{i}_heading", StripTagsParser).to_html,
            image:   BlockComposer.new(attributes['blocks'], "tile#{i}_image", StripTagsParser).to_html,
            url:     BlockComposer.new(attributes['blocks'], "tile#{i}_link", StripTagsParser).to_html,
            blog:    BlockComposer.new(attributes['blocks'], "tile#{i}_label", StripTagsParser).to_html,
            content: BlockComposer.new(attributes['blocks'], "tile#{i}_teaser", StripTagsParser).to_html
          }
        end

        # Home page text tiles x2
        attributes['text_tiles'] = []

        (1..2).each do |i|
          attributes['text_tiles'] << {
            text:    BlockComposer.new(attributes['blocks'], "text_promo_#{i}_heading", StripTagsParser).to_html,
            url:     BlockComposer.new(attributes['blocks'], "text_promo_#{i}_link", StripTagsParser).to_html,
            content: BlockComposer.new(attributes['blocks'], "text_promo_#{i}_teaser", StripTagsParser).to_html
          }
        end

        attributes['promo']       = BlockComposer.new(attributes['blocks'], 'promo').to_html
        attributes['description'] = attributes['meta_description']
        attributes['categories']  = attributes['category_names']
        attributes['alternates']  = Array(attributes['translations']).map do |translation|
          { url: translation['link'], title: translation['label'], hreflang: translation['language'] }
        end

        attributes
      end
    end
  end
end
