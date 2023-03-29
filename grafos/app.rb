# frozen_string_literal: true

Dir['./models/*.rb'].sort.each { |f| require f }
Dir['./services/*.rb'].sort.each { |f| require f }
Dir['./helpers/*.rb'].sort.each { |f| require f }

Bundler.require(:default)

# App class
class App
  include AppHelper

  def playgroud
    edges = [
      [1, 4],
      [4, 3],
      [3, 2],
      [3, 5],
      [5, 6]
    ]

    graph = UndirectedGraph.new(6, edges)
  end
end

App.new.playgroud
