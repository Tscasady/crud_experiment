require './fakes_controller'

RSpec.describe FakesController do
  let(:fakes) { FakesController.new }
  describe 'generate_index' do
    it 'creates an index method' do
      expect(fakes.respond_to?(:index)).to be true
    end
  end
end