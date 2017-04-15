require 'BaseService'
class AddService < BaseService

  def initialize(first_variable, second_variable)
    self.first_variable = first_variable
    self.second_variable = second_variable
  end

  def call
    first_variable + second_variable
  end

  private

  attr_accessor :first_variable, :second_variable
end
