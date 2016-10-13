module UsersHelper

  def check_activity action_type, target_id, user
    case action_type
    when Activity.activity_types[:follow]
      user.fullname + t("page.activity_follow") + User.find_by(id: target_id).fullname
    when Activity.activity_types[:unfollow]
      user.fullname + t("page.activity_unfollow") + User.find_by(id: target_id).fullname
    when Activity.activity_types[:create_lesson]
      user.fullname + t("page.activity_create_lesson")
    when Activity.activity_types[:finished]
      user.fullname + t("page.activity_finish_lesson")
    else
      t "none"
    end
  end

end
