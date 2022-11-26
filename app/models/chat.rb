class Chat < ApplicationRecord
  serialize :messages, Array
  belongs_to :application
end
