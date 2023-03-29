# frozen_string_literal: true

# dfs algorithm
class DepthFirstSearch
  include AppHelper

  def initialize(graph)
    @graph = graph
    @reached_vertices_arr = [false] * @graph.vertices_size
    @reached_vertices_count = 0
    @total_rounds = 0
  end

  def call(initial_vertice_id)
    get_vertice_adjacency_list_ids(initial_vertice_id).each do |vertice_id|
      @total_rounds += 1
      next if reached_vertice?(vertice_id)

      reach_vertice(vertice_id)
      res = call(vertice_id)
      raise res[:error] if res[:error]
    end

    {
      finished: true,
      reached_vertices_arr: @reached_vertices_arr,
      reached_vertices_count: @reached_vertices_count,
      rounds: @total_rounds
    }
  rescue StandardError => e
    {
      finished: false,
      error: e
    }
  end

  private

  def get_vertice_adjacency_list_ids(vertice_id)
    @graph.get_vertice_by_id(vertice_id).adjacency_list_ids
  end

  def reach_vertice(vertice_id)
    return if reached_vertice?(vertice_id)

    @reached_vertices_arr[id_to_index(vertice_id)] = true
    @reached_vertices_count += 1
  end

  def reached_vertice?(vertice_id)
    @reached_vertices_arr[id_to_index(vertice_id)]
  end
end
