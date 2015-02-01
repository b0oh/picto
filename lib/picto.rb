require 'picto/config'
require 'picto/db'

module Picto
  Db.connect
end

require 'picto/concerns'
require 'picto/image_uploader'
require 'picto/models'
