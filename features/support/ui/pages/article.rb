require_relative '../page'
require_relative '../sections/category_nav'

module UI::Pages
  class Article < UI::Page
    set_url '{/locale}/articles{/id}'

    element :content, '.l-main'
    element :related_categories, '.related-categories'
    element :breadcrumbs, '.l-context-bar'

    section :category_nav, UI::Sections::CategoryNav, 'nav .link-list-primary'
  end
end
