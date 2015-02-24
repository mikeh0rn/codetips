require 'elasticsearch/model'

class Tip < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :language, analyzer: 'english', index_options: 'offsets'
      indexes :topic, analyzer: 'english'
      indexes :text, analyzer: 'english'
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['language^10', 'topic', 'text']
          }
        },
        highlight: {
          pre_tags: ['<em>'],
          post_tags: ['</em>'],
          fields: {
            language: {},
            topic: {},
            text: {}
          }
        }
      }
    )
  end
end
Tip.__elasticsearch__.client.indices.delete index: Tip.index_name rescue nil

Tip.__elasticsearch__.client.indices.create \
  index: Tip.index_name,
  body: { settings: Tip.settings.to_hash, mappings: Tip.mappings.to_hash }

Tip.import