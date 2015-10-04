class Observer < ActiveRecord::Base
  cattr_accessor :current_user
  
  belongs_to :task

  has_many   :outdated_accounts,
             dependent: :delete_all

  has_many   :patches,
             dependent: :delete_all

  def notify(patchable, method)
    if method == :delete
      patches.where(patchable_id: patchable).destroy_all
    end
    patches.find_or_create_by(
      patchable_type: patchable.class,
      patchable_id: patchable.send(patchable.class.primary_key),
      method_id: Patch.method_names.key(method),
      user: current_user
    )
  end
end
