json.invitations do |invitation| 
	json.array! @invitations, partial: "invitations/invitation", as: :invitation
end
json.users do |user| 
	json.array! @users, partial: "users/user", as: :user
end

