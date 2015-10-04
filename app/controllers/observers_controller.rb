class ObserversController < ApplicationController
  def observe
    @observer = Observer.find_or_create_by(session_id: session[:session_id])

    # delay answer
    #i = 0
    #while ActiveRecord::Base.connection.execute("SELECT count(id) AS count FROM `patches` WHERE `patches`.`observer_id` = #{@observer.id} LIMIT 1").to_a[0][0] = 0
    #  puts ActiveRecord::Base.connection.execute("SELECT count(id) AS count FROM `patches` WHERE `patches`.`observer_id` = #{@observer.id} LIMIT 1").to_a[0][0]
    #   sleep 1
    #  break if (i += 1) > 6
    #end

    # render
    render as: :json
    @observer.patches.destroy_all
  end
end
