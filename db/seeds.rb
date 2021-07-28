nick = User.create(name: "Nick", email: "nick@nick.com", password: "password")
bob = User.create(name: "Bob", email: "bob@bob.com", password: "password")

Event.create(title: "code", description: "code talk", user_id: bob.id)
bob.events.create(title: "more code", description: "more code talk")
bobs_event = bob.events.build(title: "even more code", description: "even more code talk")
bobs_event.save

nicks_event = Event.new(title: "meeting", description: "code talk")
nick.events << nicks_event


