class StringCalculator
  def add(numbers)
    0
  end
end

require 'rspec'

RSpec.describe StringCalculator do
  it 'returns 0 for empty string' do
    calc = StringCalculator.new
    expect(calc.add("")).to eq(0)
  end
end