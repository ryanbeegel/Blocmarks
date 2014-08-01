class TopicsController < ApplicationController
  def index
    @topics = Topic.all#.include(:bookmarks)
  end

  def show
    @topic = Topic.find(params[:id]).include(:boomarks)
  end
end