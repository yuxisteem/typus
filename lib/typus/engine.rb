module Admin
  class Engine < Rails::Engine
    initializer "typus.assets.precompile" do |app|
      app.config.assets.precompile += %w(*.png *.gif)
    end
  end
end
