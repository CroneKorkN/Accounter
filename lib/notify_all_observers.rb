module NotifyAllObservers
  extend ActiveSupport::Concern
  def notify(a, b)
     "foo"
  end
end
ActiveRecord::Associations::CollectionProxy.send(:include, NotifyAllObservers)

# ckn: http://stackoverflow.com/questions/2328984/rails-extending-activerecordbase