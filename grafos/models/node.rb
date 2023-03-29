# frozen_string_literal: true

require './models/base_model'

# Defines a //grafo// node
class Node < BaseModel
  attr_reader :label

  def initialize(id, label = nil, adjacency_list_enabled: true)
    super(id)
    @adjacency_list_enabled = adjacency_list_enabled
    @adjacency_list_ids = adjacency_list_enabled? ? [] : nil
    @label = label
    validate_types
  end

  def adjacency_list_enabled?
    !!@adjacency_list_enabled
  end

  def adjacency_list_ids
    raise_unless_adjacency_list_enabled

    @adjacency_list_ids
  end

  def push_to_adjacency_list(node_id)
    raise_unless_adjacency_list_enabled
    raise 'node_id param must be a positive integer' unless positive_integer?(id)

    @adjacency_list_ids << node_id
  end

  private

  def validate_types
    raise 'id must be a positive integer' unless positive_integer?(id)
  end

  def raise_unless_adjacency_list_enabled
    raise 'adjacency list is not enabled' unless adjacency_list_enabled?
  end
end
