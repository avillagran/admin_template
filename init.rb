require File.dirname(__FILE__) + '/lib/admin_template.rb'

=begin
# Including views
%{ views }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end
=end

#if !ActionView::Base.instance_methods.include? 'at_index'
ActionView::Base.class_eval { include AdminTemplateHelpers }