# This module expands generic Mailer class to remove List-Id header from auto emails
# To expand standart function we need to create method alias chain _with_ and _without_
# Then create function _with_ and modify returned value from _without_ function
# In our case we only need to remove List-Id header

require_dependency 'mailer'

module ToryMailerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :mail, :tory
    end
  end

  module InstanceMethods
    def mail_with_tory(headers={}, &block)
      message = mail_without_tory(headers, &block)
      message['List-Id'] = nil
    end
  end
end
Mailer.send(:include, ToryMailerPatch)
