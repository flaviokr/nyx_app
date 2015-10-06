module SessionsHelper

  # Loga o usuario (user)
  def log_in(user)
    session[:user_id] = user.id
  end

  # Retorna o usuario logado atualmente (se existir um)
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # Retorna true se o usuario estiver logado
  def logged_in?
    !current_user.nil?
  end  
  
  #Retorna true se o current_user for administrador
  def admin?
    if current_user
      current_user.admin
    end
  end
  
  # Da log out no usuario
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  # Retorna true se o user for o usuario atual
  def current_user?(user)
    user == current_user
  end
end