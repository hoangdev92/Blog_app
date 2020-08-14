class Base < ApplicationRecord
    before_create :set_before_create
    before_update :set_before_update
  
    self.abstract_class = true
  
    def self.current
      Thread.current[:user]
    end
  
    def self.current=(user)
      Thread.current[:user] = user
    end
  
    def set_before_create
      if Thread.current[:user]
        if self.has_attribute?(:created_by) 
          self.created_by = Thread.current[:user][:id]
        end
      end
      if self.has_attribute?(:is_delete) 
        self.is_delete = false
      end
    end
  
    def set_before_update
      if Thread.current[:user]
        if self.has_attribute?(:updated_by) 
          self.updated_by = Thread.current[:user][:id]
        end
      end
    end
  end
  