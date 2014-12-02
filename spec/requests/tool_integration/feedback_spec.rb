RSpec.describe 'Feedback', type: :request, features: [:improvements] do
  %w(
    /en/improvements
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end