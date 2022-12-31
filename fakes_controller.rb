require './crudable'
class FakesController
  extend Crudable
  generate_methods
end