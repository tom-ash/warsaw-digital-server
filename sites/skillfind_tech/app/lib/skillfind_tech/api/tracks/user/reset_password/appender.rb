# frozen_string_literal: true

module SkillfindTech
  module Api
    module Tracks
      module User
        module ResetPassword
          class Appender < ::SkillfindTech::Api::Tracks::Common::Appender
            include ::SkillfindTech::Api::Tracks::User::ResetPassword::Meta

            NO_ERROR = { pl: '', en: '' }.freeze

            private

            def texts
              {
                pl: {
                  heading: 'Zresetuj hasło',
                  emailAddressExplanation: 'Podaj adres email przypisany do Twojego konta.',
                  emailInputLabel: 'Adres email',
                  emailInputPlaceholder: 'Podaj adres email',
                  emailInputInvalidError: 'Nieprawidłowy adres email.',
                  submitEmail: 'Dalej',
                  verificationExplanation: "Kod weryfikacyjny został wysłany na podany adres email. Wklej go poniżej i naciśnij 'Dalej'.",
                  verificationCodeInputLabel: 'Kod werifykacyjny',
                  verificationCodeInputInvalidError: 'Nieprawidłowy kod weryfikacyjny.',
                  submitVerificationCode: 'Dalej',
                  passwordExplanation: 'Podaj nowe hasło.',
                  passwordInputLabel: 'Hasło',
                  passwordInputPlaceholder: 'Podaj hasło',
                  passwordInputInvalidError: 'Hasło powinno się składać z conajmniej 6 znaków.',
                  submitPassword: 'Zmień hasło',
                  successExplanation: 'Twoje hasło zostało zmienione.',
                },
                en: {
                  heading: 'Reset password',
                  emailAddressExplanation: 'Provide the email address associated with your account.',
                  emailInputLabel: 'Email Address',
                  emailInputPlaceholder: 'Provide email address',
                  emailInputInvalidError: 'Invalid email address.',
                  submitEmail: 'Next',
                  verificationExplanation: "The verification code was sent to the provided email address. Paste it below and press 'Next'.",
                  verificationCodeInputLabel: 'Verification Code',
                  verificationCodeInputInvalidError: 'Invalid verification code.',
                  submitVerificationCode: 'Next',
                  passwordExplanation: 'Provide new password.',
                  passwordInputLabel: 'Password',
                  passwordInputPlaceholder: 'Provide password',
                  passwordInputInvalidError: 'The password has to consist at least six characters.',
                  submitPassword: 'Change password',
                  successExplanation: 'Your password has been changed.',
                },
              }[lang]
            end

            def data
              {
                apiUrl: api_url,
              }
            end

            def control
              {
                step: 'email',
                connecting: false,
              }
            end

            def errors
              {
                emailAddress: false,
                verificationCode: false,
                password: false,
              }
            end

            def asset_names
              @asset_names ||= header_asset_names
            end
          end
        end
      end
    end
  end
end
