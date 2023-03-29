# frozen_string_literal: true

require './models/base_model'
require './models/vertice'
require './models/edge'

# Defines an undirected graph G(v ,e) where:
# "v" is the size of the set of vertices and
# "e" is the set of edges on the form [[i, j], [k, l], ...],
# where i, j, k, l are vertice ids (0 < v <= e)
class UndirectedGraph < BaseModel
  attr_reader :vertices_size, :edges_by_ids, :vertices, :edges, :vertice_ids

  def initialize(vertices_size, edges_by_ids, adjacency_matrix_enabled: true)
    super()
    @vertices_size = vertices_size
    @edges_by_ids = edges_by_ids
    @vertices = []
    @vertice_ids = []
    @edges = []
    @adjacency_matrix_enabled = adjacency_matrix_enabled

    validate_types

    build_adjacency_matrix if adjacency_matrix_enabled?
    build_vertices
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

  def get_vertice_by_id(vertice_id)
    @vertices[id_to_index(vertice_id)]
  end

  private

  def build_adjacency_matrix
    raise_unless_adjacency_matrix_enabled

    @adjacency_matrix = vertices_size.times.map { [false] * vertices_size }
    @adjacency_matrix
  end

  def build_edges
    edges_by_ids.each_with_index do |edge, i|
      vertice_id_a = edge[0]
      vertice_id_b = edge[1]
      vertice_index_a = id_to_index(vertice_id_a)
      vertice_index_b = id_to_index(vertice_id_b)
      @edges << Edge.new(index_to_id(i), vertice_id_a, vertice_id_b)

      @vertices[vertice_index_a].push_to_adjacency_list(vertice_id_b)
      @vertices[vertice_index_b].push_to_adjacency_list(vertice_id_a)

      @adjacency_matrix[vertice_index_a][vertice_index_b] = true
      @adjacency_matrix[vertice_index_b][vertice_index_a] = true
    end
  end

  def build_vertices
    vertices_size.times do |i|
      id_ = index_to_id(i)
      @vertice_ids << id_
      @vertices << Vertice.new(id_)
    end
  end

  def raise_unless_adjacency_matrix_enabled
    raise 'adjacency_matrix not enabled' unless adjacency_matrix_enabled?
  end

  def validate_types
    raise 'vertices_size must be a positive integer' unless positive_integer?(vertices_size)
    raise 'edges_by_ids must be an array' unless edges_by_ids.is_a?(Array)

    edges_by_ids.each do |edge|
      raise 'edges_by_ids must be an array of arrays' unless edge.is_a?(Array)
      unless positive_integer?(edge[0]) && positive_integer?(edge[1])
        raise 'edges_by_ids tuple must respect [i, j] 0 < vertices_size <= e'
      end
    end
  end
end
