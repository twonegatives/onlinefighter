TWITTER_CONFIG  = YAML.load_file("#{::Rails.root}/config/config_twitter.yml")[::Rails.env]
FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/config_facebook.yml")[::Rails.env]
