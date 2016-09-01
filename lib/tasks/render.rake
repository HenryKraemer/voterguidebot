require_relative Rails.root.join('lib', 'static_renderer')

namespace :render do
  desc "Render an HTML pages."
  task :file, [:file, :layout] => [:environment] do |_, args|
    filename = File.basename(args.file).split('.').first
    StaticRenderer.render_file("public/avg/#{filename}.html", args.file, {}, args.layout)
  end

  desc "Render a some sub pages."
  task :subpages, :paths do |_, args|
    layout = 'layouts/avg.html.haml'
    args.paths.each do |path|
      Rake::Task['render:file'].invoke(path, layout)
      Rake::Task['render:file'].reenable
    end
  end
end
