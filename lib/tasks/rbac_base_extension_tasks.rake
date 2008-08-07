namespace :radiant do
  namespace :extensions do
    namespace :rbac_base do
      
      desc "Runs the migration of the Rbac Base extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          RbacBaseExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          RbacBaseExtension.migrator.migrate
        end
      end
      
      desc "Copies the public assets of the Rbac_Base extension into the instance's public directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[RbacBaseExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(RbacBaseExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end