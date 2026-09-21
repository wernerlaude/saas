# spec/support/request_macros.rb
# Loggt vor jedem Beispiel einen echten User über das Login-Formular ein.
# Kein Stubbing von Session/Current – dadurch funktionieren auch Layout
# und Header (Current.user.name) im Request-Spec.
module RequestMacros
  def login_user
    before do
      @user = FactoryBot.create(:user)
      post session_path, params: { email_address: @user.email_address, password: @user.password }
    end
  end
end
