module UsersVerificationCiphers
  def generate_verification
    @verification_code ||= SecureRandom.hex(4).upcase
    @record = @verification_code
    @key = Rails.application.secrets.verification_code_key
    @encrypted_verification_code, @verification_code_iv = encrypt_with_random_iv_and_salt
    @verification = { context: @context, time_limit: Time.now + 10.minutes,
                      encrypted_code: @encrypted_verification_code }
  end

  def decrypt_verification_code
    @encrypted_record = @user.verification['encrypted_code']
    @key = Rails.application.secrets.verification_code_key
    @iv = @user_cipher.verification_code_iv
    @verification_code = decrypt
  end
end