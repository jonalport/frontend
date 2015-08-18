module Core
  class HomePage < Entity
    Alternate = Struct.new(:title, :url, :hreflang)

    attr_accessor :type, :slug, :identifier, :title, :description, :body,
                  :categories, :related_content, :promo, :heading, :hero_image,
                  :bullet_1, :bullet_2, :bullet_3, :cta_text, :cta_link, 
                  :tiles, 
                  :tile1_heading, :tile1_image, :tile1_link, :tile1_label, :tile1_teaser,
                  :tile2_heading, :tile2_image, :tile2_link, :tile2_label, :tile2_teaser,
                  :tile3_heading, :tile3_image, :tile3_link, :tile3_label, :tile3_teaser,
                  :tile4_heading, :tile4_image, :tile4_link, :tile4_label, :tile4_teaser,
                  :tools, 
                  :tool_1_heading, :tool_1_link, :tool_1_teaser, 
                  :tool_2_heading, :tool_2_link, :tool_2_teaser, 
                  :tool_3_heading, :tool_3_link, :tool_3_teaser, 
                  :text_tiles, 
                  :text_promo_1_heading, :text_promo_1_link, :text_promo_1_teaser,
                  :text_promo_2_heading, :text_promo_2_link, :text_promo_2_teaser

    attr_reader :alternates

    validates_presence_of :title

    def alternates=(alternates)
      @alternates = alternates.map do |alternate|
        Alternate.new(*alternate.values_at(:title, :url, :hreflang))
      end
    end

    def only_child?
      categories.compact.one?
    end

    def callback_requestable?
      Repository::CallbackRequestable::Static.new(self).call
    end

    def latest_blog_post_links
      build_article_links 'latest_blog_post_links'
    end

    def popular_links
      build_article_links 'popular_links'
    end

    def related_links
      build_article_links 'related_links'
    end

    def previous_link
      navigation_link 'previous_link'
    end

    def next_link
      navigation_link 'next_link'
    end

    private

    def build_article_links(key)
      return [] if related_content.blank? || related_content[key].blank?
      related_content[key].map do |link_data|
        build_article_link link_data
      end
    end

    def build_article_link(data)
      ArticleLink.new(data['title'], data['path'])
    end

    def navigation_link(key)
      return nil if related_content.nil? || related_content[key].blank?

      build_article_link related_content[key]
    end
  end
end
