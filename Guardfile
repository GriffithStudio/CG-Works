# Run the Guard with 'bundle exec guard start -c'

guard 'bundler' do
	watch('Gemfile')
end

guard 'spork', :rspec_env => { 'RAILS_ENV' => 'test' } do
  # The files below will be watched and trigger the spork server to restart.
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.*\.rb$})
  watch(%r{^config/initializers/.*\.rb$})
  watch('spec/spec_helper.rb')
  watch('config/routes.rb')
  watch(%r{^spec/support/.+\.rb$})
end

guard 'rspec', :version => 2, :notify => true, :keep_failed => false, :cli => '-f doc --drb' do
  # The files below will be watched and only run the corresponding tests.
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('spec/spec_helper.rb')                        { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  watch('spec/factories.rb')                         { "spec/models" }
end