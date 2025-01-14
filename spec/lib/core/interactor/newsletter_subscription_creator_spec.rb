module Core
  RSpec.describe NewsletterSubscriptionCreator do
    let(:email) { 'clark.kent@example.com' }

    subject(:subscriber) { described_class.new(email) }

    describe '#call' do
      before do
        allow(PostcodeAnywhere::EmailValidation).to receive(:valid?) { true }
      end

      context 'when email is blank' do
        let(:result) { true }
        let(:email) { '' }

        specify { expect(subject.call).to be_falsey }
      end

      context 'when the repository result is true' do
        specify { expect(subject.call).to be_truthy }

        it 'adds delayed job' do
          expect { subject.call }.to change(Delayed::Job, :count).by(1)
        end
      end

      context 'when the repository result is false' do
        before :each do
          allow(Core::Registry::Repository).to receive(:[]).with(:newsletter_subscription) do
            double(delay: double(register: result))
          end
        end

        let(:result) { false }

        specify { expect(subject.call).to be_falsey }
      end

      context 'when a failure block is given' do
        before :each do
          allow(Core::Registry::Repository).to receive(:[]).with(:newsletter_subscription) do
            double(delay: double(register: result))
          end
        end

        let(:result) { nil }

        it 'calls the block' do
          expect { |x| (subject.call(&x)) }.to yield_with_no_args
        end
      end
    end
  end
end
