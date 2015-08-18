RSpec.describe HomeController, type: :controller do
  describe 'GET show' do
    specify do
      VCR.use_cassette 'cms/home-page' do
        get :show, locale: :en
      end

      expect(response).to be_ok
    end
  end
end
