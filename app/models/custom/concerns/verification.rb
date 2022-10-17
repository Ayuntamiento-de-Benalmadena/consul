require_dependency Rails.root.join('app', 'models', 'concerns', 'verification').to_s

module Verification
  extend ActiveSupport::Concern

  def verification_letter_sent?
    return true
  end

  def level_three_verified?
    return true if skip_verification?

    level_two_verified_at.present? || (residence_verified? && sms_verified?)
  end
end
