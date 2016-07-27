class Admin::PagesController < Admin::ResourcesController

  def rebuild_all
    notice = "Entries have been rebuilt."
    redirect_back fallback_location: admin_dashboard_index_path, notice: notice
  end

end
