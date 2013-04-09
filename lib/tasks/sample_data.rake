namespace :db do
  desc "Fill database with sample data"
  
  
  task populate: :environment do
    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
    # You might have noticed that Listing 9.41 makes the user an admin with toggle!(:admin), but why not just add admin: true 
    # to the initialization hash? The answer is, it won’t work, and this is by design: only attr_accessible attributes can be 
    # assigned through mass assignment (that is, using an initialization hash, as in User.new(name: "Foo", ...)), 
    # and the admin attribute isn’t accessible
    
    # Explicitly defining accessible attributes is crucial for good site security. If we omitted the attr_accessible list in the User 
    # model (or foolishly added :admin to the list), a malicious user could send a PUT request as follows:7
    # put /users/17?admin=1
    # This request would make user 17 an admin, which would be a potentially serious security breach, to say the least. 
    # Because of this danger, it is a good practice to define attr_accessible for every model.
    
      
        
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end