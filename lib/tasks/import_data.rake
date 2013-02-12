namespace :import_data do

  desc "Import users"
  task :import_users, [:file] => :environment do |t, args|
    # Load YAML file, should be array of user hash rows
    if (args.file.nil?)
      raise "Must provide YAML file input"
    end

    users = YAML::load(File.open(args.file))
    users.each do |user|
      User.find_or_create_by_name(
        :name => user[:name],
        :email => "#{user[:name].downcase}@hippohonk.com",
        :email_confirmation => "#{user[:name].downcase}@hippohonk.com",
        :password => user[:name],
        :password_confirmation => user[:name],
      )
    end
  end

  desc "Import bands"
  task :import_bands, [:file] => :environment do |t, args|
    # Load YAML file, should be array of band hash rows
    if (args.file.nil?)
      raise "Must provide YAML file input"
    end

    bands = YAML::load(File.open(args.file))
    bands.each do |band|
      Band.find_or_create_by_name(
        :name => band[:name],
        :location => band[:location],
        :url => band[:url],
        :description => band[:description],
      )
    end
  end

  desc "Import ratings"
  task :import_ratings, [:file] => :environment do |t, args|
    # Load YAML file, should be array of band hash rows
    if (args.file.nil?)
      raise "Must provide YAML file input"
    end

    ratings = YAML::load(File.open(args.file))
    ratings.each do |rating|
      if (band = Band.find_by_name(rating[:band])) &&
        (user = User.find_by_name(rating[:user]))
        @rating = Rating.find_or_create_by_band_id_and_user_id(
          band.id, user.id)
        @rating.rating = rating[:rating]
        @rating.save
      end
    end
  end

  desc "Import lineup"
  task :import_lineup, [:file, :festival] => :environment do |t, args|
    # Load YAML file, should be array of band hash rows
    if (args.file.nil?)
      raise "Must provide YAML file input"
    end

    if (args.festival.nil?)
      raise "Must provide a festival"
    end

    if (festival = Festival.find_by_name(args.festival))
      bands = YAML::load(File.open(args.file))
      bands.each do |band|
        if (band = Band.find_by_name(band[:name]))
          Lineup.create(:festival => festival, :band => band)
        end
      end
    end
  end
end
