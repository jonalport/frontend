RSpec.describe 'DebtAndMentalHealth', type: :request, features: [:debt_and_mental_health] do
  [ "en/tools/#{ToolMountPoint::DebtMentalHealth::EN_ID}",
    "cy/tools/#{ToolMountPoint::DebtMentalHealth::CY_ID}"
  ].each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
