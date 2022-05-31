Rails.application.config.middleware.use OmniAuth::Builder do
    if Rails.env.development? || Rails.env.test?
        provider :github, "5bbf99f95936f002d76a", "39d159e5910fe237fbd37ea8fcc07edf473324c4"
    end
end