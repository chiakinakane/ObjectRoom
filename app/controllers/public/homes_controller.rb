class Public::HomesController < ApplicationController
  def top
    #@new_ideas = Idea.all.order("created_at DESC").first(4)
    @genres = Genre.all
  end

  def about
  end
end
