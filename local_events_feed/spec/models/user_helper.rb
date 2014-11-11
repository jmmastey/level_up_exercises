
def create_user(name, email, password = 'pass-me', confirm = 'pass-me')
  User.create(name: name,
              email: email,
              password: password,
              password_confirmation: confirm)
end
