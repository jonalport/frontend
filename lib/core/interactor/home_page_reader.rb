module Core
  class HomePageReader < BaseContentReader
    private

    def entity_class
      HomePage
    end

    def repository
      Registry::Repository[:home_page]
    end
  end
end
