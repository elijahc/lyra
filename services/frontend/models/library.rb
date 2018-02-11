require 'mongoid'
require 'roar'

class Library
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name,    type: String
    field :strategy, type: String
    field :sp_primer, type: String
    field :ref_seq, type: String
    field :region_start, type: Integer
    field :region_stop, type: Integer
    field :built, type: Boolean
    
end

module LibraryRepresenter
    include Roar::JSON::HAL
  
    property :name
    property :created_at, :writeable=>false
  
    link :self do
      "/library/#{id}"
    end
end

class Guide
    include Mongoid::Document
    include Mongoid::Timestamps

    field :sequence, type: String
end