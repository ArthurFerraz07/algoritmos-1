# frozen_string_literal: true

# Algorithms who uses dfs algorithm to afirm something
module DFS
  # Standard dfs algorithm
  class DepthFirstSearch
    include AppHelper

    def initialize(graph)
      @graph = graph
      @reached_vertices_arr = [false] * @graph.vertices_size
      @reached_vertices_count = 0
      @total_rounds = 0
      @vertices_adjacency_lists = @graph.vertices.map(&:adjacency_list_ids)
    end

    def call(initial_vertice_id)
      return response(true) if reached_vertice?(initial_vertice_id)

      reach_vertice(initial_vertice_id)

      get_vertice_adjacency_list_ids(initial_vertice_id).each do |vertice_id|
        @total_rounds += 1

        res = call(vertice_id)
        raise res[:error] if res[:error]
      end

      response(true)
    rescue StandardError => e
      response(false, e)
    end

    private

    def get_vertice_adjacency_list_ids(vertice_id)
      # @vertices_adjacency_lists[id_to_index(vertice_id)]
      @graph.get_vertice_by_id(vertice_id).adjacency_list_ids
    end

    def reach_vertice(vertice_id)
      return if reached_vertice?(vertice_id)

      @reached_vertices_arr[id_to_index(vertice_id)] = true
      @vertices_adjacency_lists[id_to_index(vertice_id)] = @vertices_adjacency_lists[id_to_index(vertice_id)][1..] || []
      @reached_vertices_count += 1
    end

    def response(finished, error = nil)
      {
        finished: finished,
        reached_vertices_arr: @reached_vertices_arr,
        reached_vertices_count: @reached_vertices_count,
        rounds: @total_rounds,
        error: error
      }
    end

    def reached_vertice?(vertice_id)
      @reached_vertices_arr[id_to_index(vertice_id)]
    end
  end
end
