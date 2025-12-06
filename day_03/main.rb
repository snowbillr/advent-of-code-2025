class Parser
  def initialize(file_path:)
    @file_path = file_path
  end

  def parse
    banks = []
    File.open(@file_path, 'r') do |f|
      f.each_line do |line|
        bank = line.chomp.split('').map(&:to_i)
        banks << bank
      end
    end

    banks
  end
end

class Part1Solver
  def initialize
    @banks = Parser.new(file_path: './day_03/input.txt').parse
  end

  def run
    @banks.map do |bank|
      # puts "----#{bank}----"
      largest_num_index = find_largest_number_index_with_subsequent_numbers(bank.slice(0, bank.length - 1))
      largest_num = bank[largest_num_index]

      # puts "largest num: #{largest_num}"

      remaining_bank = bank.slice(largest_num_index + 1, bank.length)

      # puts "remaining bank: #{remaining_bank}"
      remaining_largest_num_index = find_largest_number_index_with_subsequent_numbers(remaining_bank)
      remaining_largest_num = remaining_bank[remaining_largest_num_index]

      "#{largest_num}#{remaining_largest_num}".to_i
    end.sum
  end

  private def find_largest_number_index_with_subsequent_numbers(bank)
    largest_num = 0
    largest_index = 0

    bank.each_with_index do |v, i|
      if v > largest_num
        largest_num = v
        largest_index = i
      end
    end

    largest_index
  end
end

puts Part1Solver.new.run