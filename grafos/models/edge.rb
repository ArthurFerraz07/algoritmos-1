# frozen_string_literal: true

require './models/base_model'

# An edge is a conection between two vertices
class Edge < BaseModel
  attr_reader :from_id, :to_id

  def initialize(id, from_id, to_id)
    super(id)
    @from_id = from_id
    @to_id = to_id
    validate_types
  end

  private

  def validate_types
    raise 'id must be a positive integer' unless positive_integer?(id)
    raise 'from_id must be a positive integer' unless positive_integer?(from_id)
    raise 'to_id must be a positive integer' unless positive_integer?(to_id)
  end
end
