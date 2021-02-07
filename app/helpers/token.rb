module Token
  
  EXP = (24 * 3 * 3600)
  ALGO = 'HS512'.freeze
  SECRET = ENV['SECRET_KEY_BASE']

  attr_accessor :message, :token

  def self.build_from_user(user)
    payload = { user_id: user.id, exp: (Time.now.to_i + EXP) }
    token = JWT.encode payload, SECRET, ALGO
    new(token: token)
  end

  def self.check_invalid_token(token)
    payload, _header = JWT.decode token, SECRET, true, { algorithm: ALGO }
    time_exp = Time.now.to_i > payload['exp']
    [payload, time_exp]
  rescue JWT::DecodeError
    nil
  end

  def self.get_user_from_request(request)
    token = get_token(request)
    payload, _header = JWT.decode token, SECRET, true, { algorithm: ALGO }
    User.find_by id: payload['user_id']
  rescue JWT::DecodeError
    nil
  end

  def self.get_token(request)
    if request.headers['Authorization'].present?
      request.headers['Authorization'].gsub('Bearer ', '')
    elsif request.headers[:HTTP_SEC_WEBSOCKET_PROTOCOL].present?
      request.headers[:HTTP_SEC_WEBSOCKET_PROTOCOL].split(' ').last
    end
  rescue StandardError
    nil
  end
end
