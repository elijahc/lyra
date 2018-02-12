require 'mongoid'
require 'bcrypt'
require 'roar/json/hal'

class User
    include Mongoid::Document
    include Mongoid::Timestamps

    field :username, type: String
    field :email, type: String
    field :password, type: String
    field :admin, type: Boolean
    has_many :library

    def check_pass(challenge)
        true_pass = BCrypt::Password.new self.password
        return true_pass == challenge
    end
end

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
    belongs_to :user
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
