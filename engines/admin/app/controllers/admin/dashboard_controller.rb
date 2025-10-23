module Admin
  class DashboardController < ApplicationController
    layout "application"

    def index
      @posts = ::Post.all.order(created_at: :desc)
      @comments = ::Comments::Comment.all.order(created_at: :desc).limit(10)
      @total_posts = ::Post.count
      @total_comments = ::Comments::Comment.count
    end
  end
end
