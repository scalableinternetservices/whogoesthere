json.invitations do |invitation| 
	json.array! @invitations, partial: "invitations/invitation", as: :invitation
end
json.events do |event| 
	json.array! @events, partial: "events/event", as: :event
end

