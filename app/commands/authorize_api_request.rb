class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
    @server_url = ENV["KEYCLOAK_SERVER_URL"]
    @realm_name = ENV["KEYCLOAK_REALM_NAME"]
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find_by(name: decoded_auth_token[:preferred_username]) if decoded_auth_token
    @user || nil 
  end

  def decoded_auth_token
    if headers['Authorization'].present?
      @decoded_auth_token ||= decode(http_auth_header)
    else
      errors.add(:token, 'Missing token') && nil
    end
  end

  def http_auth_header
    headers['Authorization'].split(' ').last
  end

  def get_keys
    response = HTTParty.get(build_uri(@realm_name, "protocol/openid-connect/certs"))
    json = MultiJson.load(response.body)

    cert = json["keys"][0]

    cert
  end

  def build_uri(realm_name, path)
    string_uri = File.join(@server_url, "auth/realms", realm_name, path)
  end

  def decode(token)

    jwk = JSON::JWK.new(get_keys)

    id_token = JSON::JWT.decode(token, jwk)

    unless expired?(id_token)
      id_token.verify!(jwk)	    
      HashWithIndifferentAccess.new id_token
    else
      errors.add(:token, 'Expired token')
    end  
  rescue
    errors.add(:token, 'Invalid token') && nil
  end

  def expired?(token)
    token_expiration = Time.at(token["exp"]).to_datetime
    token_expiration < Time.now 
  end
end
