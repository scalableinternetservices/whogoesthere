json.comments do |comment| 
	json.array! @comments, partial: "comments/comment", as: :user
end

json.users do |user| 
	json.array! @users, partial: "users/user", as: :user
end
