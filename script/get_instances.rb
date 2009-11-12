require 'rubygems'
require 'activeresource'

SITE = 'http://user:pass@localhost:9393/'

class Instance < ActiveResource::Base
  self.site = SITE
  self.format = :json
  self.logger = Logger.new($stderr)
end

# new
instance = Instance.new(:user_id=>1, :physicalhost_id=>10,
                        :imagestorage_id=>100,
                        :hvspec_id=>1)
instance.save

# update
instance.user_id = 2
instance.save

id = instance.id

# get
get_instance = Instance.find(id)

# delete
instance.destroy

# list
list = Instance.find(:all)
for instance in list do
  p instance
end

