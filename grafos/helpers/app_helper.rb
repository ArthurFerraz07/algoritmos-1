# frozen_string_literal: true

# This module contains until generic methods
module AppHelper
  def positive_integer?(number)
    number.is_a?(Integer) && number.positive?
  end

  def index_to_id(index)
    index + 1
  end

  def id_to_index(id)
    id - 1
  end

  def print_adjacency_matrix(adjacency_matrix)
    adjacency_matrix.each do |line|
      print '[ '
      print line.map { |word| centralize_string(word.to_s, 7) }.join(', ')
      print ' ]'
      print "\n"
    end
    nil
  end

  def centralize_string(str, size)
    diff = size.to_i - str.size
    return str[0..size] if diff <= 0

    left_pad = ' ' * (diff / 2)
    right_pad = ' ' * (diff / 2)

    right_pad << ' ' if diff.odd?

    left_pad + str + right_pad
  end
end
