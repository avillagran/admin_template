namespace :admin_template do
  namespace :install do
    desc 'Install required stylesheet for plugin'
    task :stylesheets do
      puts 'Copying files...'
      project_dir = Rails.root.to_s + '/public/stylesheets/'
      scripts = File.join(File.dirname(__FILE__), '../../..', '/stylesheets/admin_template')
      FileUtils.cp_r(scripts, project_dir)
      puts 'files copied successfully.'
    end
  end

  desc 'Install stylesheets/javascripts for admin_template'
  task :install do
    Rake::Task['admin_template:install:stylesheets'].invoke
  end
end