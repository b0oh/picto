require 'picto/config'
require 'picto/db'

module Picto
  Db.connect
end

require 'picto/models'
