module Social
  def self.receive_user(provider, access_token)
    @provider = Sorcery::Controller::Config.send(provider.to_sym)
    @access_token = OAuth2::AccessToken.from_hash(@provider.build_client, 'access_token' => access_token)
    @provider.get_user_hash(@access_token)
  end
end
