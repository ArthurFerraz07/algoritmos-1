# frozen_string_literal: true

require './models/base_model'
require './models/node'
require './models/edge'

# Defines the not directional //grafo// G(v ,e) where:
# "v" is the set of nodes and
# "e" is the set of edges on the form [[i, j], [k, l], ...],
# where i, j, k, l are node ids (0 < v <= e)
class Grafo < BaseModel
  attr_reader :nodes_size, :edges_by_ids, :nodes, :edges

  def initialize(nodes_size, edges_by_ids, adjacency_matrix_enabled: true)
    super(rand(100_000..999_999))
    @nodes_size = nodes_size
    @edges_by_ids = edges_by_ids
    @nodes = []
    @edges = []
    @adjacency_matrix_enabled = adjacency_matrix_enabled

    validate_types

    build_adjacency_matrix if adjacency_matrix_enabled?
    build_nodes
    build_edges
  end

  def adjacency_matrix
    raise_unless_adjacency_matrix_enabled

    return @adjacency_matrix if @adjacency_matrix

    build_adjacency_matrix
  end

  def adjacency_matrix_enabled?
    !!@adjacency_matrix_enabled
  end

  private

  def build_adjacency_matrix
    raise_unless_adjacency_matrix_enabled

    @adjacency_matrix = nodes_size.times.map { [false] * nodes_size }
    @adjacency_matrix
  end

  def build_edges
    edges_by_ids.each_with_index do |edge, i|
      node_id_a = edge[0]
      node_id_b = edge[1]
      node_index_a = id_to_index(node_id_a)
      node_index_b = id_to_index(node_id_b)
      @edges << Edge.new(index_to_id(i), node_id_a, node_id_b)

      @nodes[node_index_a].push_to_adjacency_list(node_id_b)
      @nodes[node_index_b].push_to_adjacency_list(node_id_a)

      @adjacency_matrix[node_index_a][node_index_b] = true
      @adjacency_matrix[node_index_b][node_index_a] = true
    end
  end

  def build_nodes
    nodes_size.times do |i|
      @nodes << Node.new(index_to_id(i))
    end
  end

  def raise_unless_adjacency_matrix_enabled
    raise 'adjacency_matrix not enabled' unless adjacency_matrix_enabled?
  end

  def validate_types
    raise 'nodes_size must be a positive integer' unless positive_integer?(nodes_size)
    raise 'edges_by_ids must be an array' unless edges_by_ids.is_a?(Array)

    edges_by_ids.each do |edge|
      raise 'edges_by_ids must be an array of arrays' unless edge.is_a?(Array)
      unless positive_integer?(edge[0]) && positive_integer?(edge[1])
        raise 'edges_by_ids tuple must respect [i, j] 0 < nodes_size <= e'
      end
    end
  end
end
