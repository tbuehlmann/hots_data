# frozen_string_literal: true

require 'set'

module HotsData
  class Entity
    class << self
      attr_accessor :attributes

      def inherited(subclass)
        subclass.attributes = Set.new
      end

      def attribute(name)
        name = name.to_s
        @attributes << name

        define_method(name) do
          attributes[name]
        end

        define_method("#{name}=") do |value|
          attributes[name] = value
        end
      end
    end

    attr_reader :attributes
    attr_accessor :client

    def initialize(attributes = {})
      @attributes = {}
      assign_attributes(attributes)
    end

    def assign_attributes(attributes)
      valid_attributes = self.class.attributes

      attributes.each do |attribute, value|
        attribute = attribute.to_s

        if valid_attributes.include?(attribute)
          public_send("#{attribute}=", value)
        else
          warn "Attribute not known: #{attribute}"
        end
      end
    end
  end
end
