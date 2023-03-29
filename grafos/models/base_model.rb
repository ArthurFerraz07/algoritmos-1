# frozen_string_literal: true

require './helpers/app_helper'

# Application base model
class BaseModel
  include AppHelper

  attr_reader :id

  def initialize(id)
    @id = id
  end

  def index
    raise 'missing id' unless @id

    @id - 1
  end
end
