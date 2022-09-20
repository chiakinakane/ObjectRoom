class ApplicationController < ActionController::Base
  # ログイン後の遷移先指定
    def after_sign_in_path_for(resource)
    about_path #遷移させたいページのpathを記述
  end
end
