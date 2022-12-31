module Crudable
    class.eval do
      "#{self.class}"
    end
end

#index, edit, destroy, update, create, new
#get the class name
#sanitize it
#create the method
#dont let the class call crudable methods
