namespace :pictures do

  desc "Recreate all versions of all pictures"
  task recreate: :environment do
    Picture.all.each { |p| p.picture.recreate_versions! }
  end

end

