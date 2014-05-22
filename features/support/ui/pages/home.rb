require_relative '../page'

module UI::Pages
  class Home < UI::Page
    set_url '/{locale}'

    element :strapline, '.home-feature__content h1'
    element :feature_list, '.home-feature__list'
    elements :promoted_items, '.home-promoted__item'
    element :directory_items, '.directory'

    element :contact_heading, 'h2.contact__heading'
    element :contact_introduction, '.contact__text'
    element :contact_number, '.contact__number'
  end
end
