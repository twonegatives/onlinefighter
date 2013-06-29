TWITTER_CONFIG    = YAML.load_file("#{::Rails.root}/config/config_twitter.yml")[::Rails.env]
FACEBOOK_CONFIG   = YAML.load_file("#{::Rails.root}/config/config_facebook.yml")[::Rails.env]
VKONTAKTE_CONFIG  = YAML.load_file("#{::Rails.root}/config/config_vkontakte.yml")[::Rails.env]
