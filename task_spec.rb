class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    delimiter = /,|\n/
    if numbers.start_with?("//")
      parts = numbers.split("\n", 2)
      delimiter = Regexp.escape(parts[0][2])
      numbers = parts[1]
    end

    nums = numbers.split(/#{delimiter}/).map(&:to_i)

    negatives = nums.select { |n| n < 0 }
    unless negatives.empty?
      raise "negative numbers are not allowed: #{negatives.join(', ')}"
    end

    nums.sum
  end
end

require 'rspec'

RSpec.describe StringCalculator do
  it 'returns 0 for empty string' do
    calc = StringCalculator.new
    expect(calc.add("")).to eq(0)
  end
  it 'returns the number itself when only one number is provided' do
    calc = StringCalculator.new
    expect(calc.add("5")).to eq(5)
  end
  it 'returns the sum of two numbers' do
    calc = StringCalculator.new
    expect(calc.add("1,2")).to eq(3)
  end
  it 'returns the sum of multiple numbers' do
    calc = StringCalculator.new
    expect(calc.add("1,2,3,4")).to eq(10)
  end

  it 'handles newlines between numbers' do
    calc = StringCalculator.new
    expect(calc.add("1\n2,3")).to eq(6)
  end

  it 'supports custom delimiters' do
    calc = StringCalculator.new
    expect(calc.add("//;\n1;2")).to eq(3)
  end

  it 'raises an exception for negative numbers' do
    calc = StringCalculator.new
    expect { calc.add("1,-2,3,-4") }.to raise_error("negative numbers are not allowed: -2, -4")
  end
end