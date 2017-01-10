Pod::Spec.new do |spec|
    spec.name = "IngresseSDK"
    spec.version = "0.0.1"
    spec.summary = "Ingresse API usage SDK."
    spec.homepage = "https://github.com/ingresse/ios-sdk"
    spec.license = { type: 'MIT', file: 'LICENSE' }
    spec.authors = { "Ingresse" => 'mobile@ingresse.com' }
    spec.social_media_url = "http://twitter.com/ingresse"

    spec.ios.deployment_target = '8.0'
    spec.requires_arc = true
    spec.source = { git: "https://github.com/ingresse/ios-sdk.git", tag: "v#{spec.version}", submodules: true }
    spec.source_files = "IngresseSDK/**/*.{h,swift}"
end
