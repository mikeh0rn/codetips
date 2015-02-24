require 'elasticsearch/model'

class Tip < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end
Tip.import