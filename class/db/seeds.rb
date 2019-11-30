# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


@total_users = 15000

@i = 1
@total_events = 0
while @i <= @total_users do
   @user = User.create(:name => "name_#{@i}", :email => "name_#{@i}@test.com")
   @event_count = rand(2 .. 10)
   @j = 1
   while @j <= @event_count do
     @name = "name_#{@i}_event_#{@j}"
     
     if @j == @event_count
       @name = "last_event"
     end

     if @j == 1
       @name = "first_event"
     end
     @event = @user.events.new( :name =>  @name,
        :description => "An event by name_#{@i}, event number is #{@j}",
        :location => (["Mercury", "Venus", "Saturn", "Jupyter", "Uranus", "Neptune"].sample(1)[0]),
        :start_time => "13-12-2019".to_date,
        :end_time => "14-12-2019".to_date,
        :user_id => @i
    )
    @event.save
    @j += 1
   end
   @total_events = @total_events + @event_count
   @i += 1

end

@i = 1
while @i <= @total_users do
  @invitation_count = rand(10 .. 20)
  @k = 1
  while @k <= @invitation_count
    @event_id = rand(1 .. @total_events)
    @invitation = Invitation.new(:user_id => @i, :event_id => @event_id)
    @invitation.save
    @comment = Comment.new(:user_id => @i, :event_id => @event_id, :body => rand(36**100).to_s(36))
    @comment.save
    @k += 1
  end
  @i += 1
end


