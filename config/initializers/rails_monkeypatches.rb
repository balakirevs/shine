if Rails.version =~ /^5/
  module ActionController 
    module ImplicitRender 
      # Current implementation doesn't work
#      def default_render(*args) 
#        render(*args) 
#      end 
    end 
  end
end