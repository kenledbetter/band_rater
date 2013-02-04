namespace :test_data do
  tasks = []

  desc "Add test bands"
  task :add_test_bands => :environment do
    puts "Adding test bands"
    adjectives = [
      "Ice",
      "Old",
      "Original",
      "Royal",
      "Gold",
      "Skinny",
      "Alpha",
    ]

    nouns = [
      "Belle",
      "Fields",
      "Dice",
      "Weekend",
      "Children",
      "Chairs",
      "Sled",
    ]
  
    bands = []

    description =
      "A fusion, bluegrass, afrobeat band from Seattle with nine cello players."

    begin
      adjective = adjectives.sample
      noun = nouns.sample

      if (rand(2) == 0)
        band = "The #{adjective} #{noun}"
      else
        band = "#{adjective} #{noun}"
      end

      if (bands.index(band) == nil)
        bands.push(band)
      end

    end while (bands.length != 20)

    bands.each do |band|
      Band.find_or_create_by_name(:name => band, :description => description)
    end
  end
  tasks.push(:add_test_bands)

  desc "Add test users"
  task :add_test_users => :environment do
    puts "Adding test users"

    ["Scott", "Jean", "Hank", "Bobby", "Warren"].each do |user|
      User.find_or_create_by_email(
        :email => user,
        :password => user,
        :password_confirmation => user
      )
    end
  end
  tasks.push(:add_test_users)

  desc "Add test ratings"
  task :add_test_ratings => :environment do
    puts "Adding test ratings"

    Band.find(:all).each do |band|
      User.find(:all).each do |user|
        # Give each user a 66% chance of adding a rating
        if (rand(3) != 0)
          Rating.create(
            :rating => rand(6),
            :band_id => band.id,
            :user_id => user.id
          )
        end
      end
    end
  end
  tasks.push(:add_test_ratings)

  desc "Add test festivals"
  task :add_test_festivals => :environment do
    puts "Adding test festivals"

    ["SXSW 2013", "ACL 2013", "FFF 2013"].each do |festival_name|
      Festival.find_or_create_by_name(festival_name)
    end
  end
  tasks.push(:add_test_festivals)

  desc "Assign bands to festivals"
  task :assign_bands_to_festivals => :environment do
    puts "Assign bands to festivals"
    Band.find(:all).each do |band|
      Festival.find(:all).each do |festival|
        # Give each band a 66% chance of assign a festival
        if (rand(3) != 0)
          festival.bands << band
        end
      end
    end
  end
  tasks.push(:assign_bands_to_festivals)

  task :all => tasks
end
