module Crudable

  def generate_methods
    generate_index
    generate_show
    generate_edit
    generate_destroy
    generate_update
    generate_create
  end

  def generate_index
    class_eval(
      "def index
        @#{klass.singularize} = #{klass}.all
      end")
  end

  def generate_show
    class_eval(
      "def show
        @#{klass.singularize} = #{klass}.find(params[:id])
        redirect_to \"#{klass_lower}/\#\{@#{klass.singularize}.id\}\"
      end"
    )
  end

  def generate_edit
    class_eval(
      "def edit
        @#{klass.singularize} = #{klass}.find(params[:id])
      end"
    )
  end

  def generate_destroy
    class_eval(
      "def destroy
        @#{klass.singularize} = #{klass}.find(params[:id]).destroy
        redirect_to #{klass_lower}_path
      end"
    )
  end

  def generate_update
    class_eval(
      "def update
        @#{klass.singularize} = #{klass}.find(params[:id])
        @#{klass}.update!(#{klass_lower}_params)
        #{klass_lower}_path(@#{klass.singularize})
      end"
    )
  end

  def generate_create
    class_eval(
      "def create
        @#{klass.singularize} = #{klass}.new(#{klass_lower}_params)     
          if @#{klass.singularize}.save
            flash[:success] = 'Update Successful'
            redirect_to #{klass_lower}_path(@#{klass.singularize}) 
          else
            flash[:alert] = @new_application.errors.full_messages.to_sentence #'Unsuccessful - Please Try Again' 
            render :new
          end
        end
        redirect_to #{klass_lower}
      end"
    )
  end

  def klass
    self.class.to_s.gsub(/Controller/, "")
  end

  def klass_lower
    klass.downcase
  end
end

#dont let the class call crudable method builder methods after methods have been built
