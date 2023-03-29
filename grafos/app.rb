# frozen_string_literal: true

Dir['./models/*.rb'].each { |f| require f }
Dir['./services/*.rb'].each { |f| require f }
Dir['./helpers/*.rb'].each { |f| require f }

Bundler.require(:default)

include AppHelper

edges = [
  [1, 4],
  [4, 3],
  [3, 2],
  [3, 5],
  [5, 6]
]

grafo = Grafo.new(6, edges)

print_adjacency_matrix(grafo.adjacency_matrix)

# binding.pry
