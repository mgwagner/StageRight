json.extract! user, :id, :email, :username, :password, :first_name, :last_name, :phone, :created_at, :updated_at
json.url user_url(user, format: :json)
