require 'grape'
require 'grape/hal/dsl'
require 'grape/hal/endpoint'

module Grape
  module Hal

    def self.included(base)
      base.extend(Dsl)
    end

  end
end