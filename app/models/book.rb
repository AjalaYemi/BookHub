
	require 'elasticsearch/model'

class Book < ActiveRecord::Base



	include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  acts_as_url :name, blacklist: %w{new search contact_us}

  acts_as_commentable

  acts_as_taggable
  acts_as_taggable_on :author, :genre

	mount_uploader :front_avatar, AvatarUploader
	has_many :reviews
	has_many :comments
	has_many :book_exchanges
	has_many :users, :through => :book_exchanges
	has_and_belongs_to_many :authors
	# has_and_belongs_to_many :genres

	# before_validation :add_default_permalink
	# after_save :touch_author

	validates_presence_of :name
	validates_length_of :name, :maximum => 100
	validates_presence_of :publisher

	scope :sorted, lambda { order("books.name ASC")}
	scope :newest_first, lambda { order("books.created_at DESC")}
	# scope :search, lambda {|query|
	# 	where(["name LIKE ?", "%#{query}%"])
	# }


	def self.search(query)
 	 __elasticsearch__.search(
   	 {
    	  query: {
     	   multi_match: {
      	    query: query,
      	    fields: ['name^10', 'bio']
      	  }
     	 },
     	 highlight: {
        pre_tags: ['<em>'],
        post_tags: ['</em>'],
        fields: {
          name: {},
          bio: {}
        }
      }
    	}
  	)
	end

	settings index: { number_of_shards: 1 } do
  	mappings dynamic: 'false' do
    	indexes :name, analyzer: 'english', index_options: 'offsets'
    	indexes :bio, analyzer: 'english'
  	end
	end

  def to_param
    url # or whatever you set :url_attribute to
  end

	private

	# def add_default_permalink
	# 	if permalink.blank?
	# 		self.permalink = "#{id}-#{name.parameterize}"
	# 	end
	# end
end

# Delete the previous articles index in Elasticsearch
Book.__elasticsearch__.client.indices.delete index: Book.index_name rescue nil

# Create the new index with the new mapping
Book.__elasticsearch__.client.indices.create \
  index: Book.index_name,
  body: { settings: Book.settings.to_hash, mappings: Book.mappings.to_hash }

# Index all article records from the DB to Elasticsearch
Book.import
