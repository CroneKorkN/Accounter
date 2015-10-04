class Record < ActiveRecord::Base
  belongs_to :task

  has_many   :observers,
             through: :task

  has_many   :entries,
             dependent: :destroy

  has_many   :patches,
             as: :patchable

  default_scope { order(:order) }

  after_create do
    observers.each do |observer|
      observer.notify(self, :create)
    end
  end

  after_destroy do
    observers.each do |observer|
      observer.notify(self, :delete)
    end
  end
end
