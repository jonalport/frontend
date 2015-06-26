RSpec.describe 'DebtAndMentalHealth', type: :request, features: [:debt_and_mental_health] do
  [
    "en/#{ToolMountPoint::DebtAndMentalHealth::EN_ID}",
  ].each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
