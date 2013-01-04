module Some
  CONFIG = YAML.load_file('config/some.yml')[Rails.env]
end
