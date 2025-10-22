# This migration comes from analytics (originally 20251022113821)
class CreateAnalyticsPageViews < ActiveRecord::Migration[7.1]
  def change
    create_table :analytics_page_views do |t|
      t.string :path
      t.string :ip_address
      t.string :user_agent
      t.string :referer
      t.datetime :visited_at

      t.timestamps
    end

    add_index :analytics_page_views, :path
    add_index :analytics_page_views, :visited_at
  end
end
