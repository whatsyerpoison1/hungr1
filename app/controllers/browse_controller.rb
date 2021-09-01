class BrowseController < ApplicationController
  def browse
    excluded_ids = Like.where(user_id: current_user.id).pluck(:liked_user_id)
    excluded_ids << current_user.id
    @users = User.where.not(id: excluded_ids).includes(images_attachments: :blob)
  end

  def matches
    @matches = current_user.matches.includes(images_attachments: :blob)
  end

  def approve
    user_id = params[:id]
    new_like = Like.new(liked_user_id: user_id)
    new_like.user_id = current_user.id

    if new_like.save
      existing_likes = Like.where(user_id: user_id, liked_user_id: current_user.id).count
      @they_like_us = existing_likes > 0
    else
      # return a warning message
    end
  end

  def decline
    logger.debug "Decline: #{params[:id]}"
    # swipes left
  end
end
