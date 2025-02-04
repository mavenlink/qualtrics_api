require "active_support/core_ext/hash"
require "active_support/core_ext/string"

require 'json'
require 'open-uri'
require 'virtus'
require "faraday"
require "faraday/follow_redirects"
require "faraday/multipart"

require "qualtrics_api/version"
require "qualtrics_api/request_error_handler"

require "qualtrics_api/configurable"
require "qualtrics_api/connectable"
require "qualtrics_api/client"

require "qualtrics_api/extensions/serializable_model"
require "qualtrics_api/extensions/serializable_collection"
require "qualtrics_api/extensions/virtus_attributes"

require "qualtrics_api/base_model"
require "qualtrics_api/base_collection"
require "qualtrics_api/library"

require "qualtrics_api/directory"
require "qualtrics_api/directory_collection"
require "qualtrics_api/directory_contact"
require "qualtrics_api/directory_contact_collection"
require "qualtrics_api/directory_contact_import"
require "qualtrics_api/directory_mailing_list"
require "qualtrics_api/directory_mailing_list_collection"
require "qualtrics_api/directory_transaction_batch"
require "qualtrics_api/directory_transaction_batch_collection"
require "qualtrics_api/distribution"
require "qualtrics_api/distribution_collection"
require "qualtrics_api/event_subscription"
require "qualtrics_api/event_subscription_collection"
require "qualtrics_api/group"
require "qualtrics_api/group_collection"
require "qualtrics_api/library_message"
require "qualtrics_api/library_message_collection"
require "qualtrics_api/panel"
require "qualtrics_api/panel_collection"
require "qualtrics_api/panel_import"
require "qualtrics_api/panel_member"
require "qualtrics_api/panel_member_collection"
require "qualtrics_api/response_export"
require "qualtrics_api/response_export_collection"
require "qualtrics_api/survey"
require "qualtrics_api/survey_collection"
require "qualtrics_api/user"
require "qualtrics_api/user_collection"

require "qualtrics_api/services/response_export_service"

module QualtricsAPI
  class << self
    include QualtricsAPI::Configurable
    extend Forwardable

    def_delegator :client, :surveys
    def_delegator :client, :response_exports
    def_delegator :client, :panels
    def_delegator :client, :event_subscriptions
    def_delegator :client, :users
    def_delegator :client, :distributions
    def_delegator :client, :groups
    def_delegator :client, :directories

    def connection(parent = nil)
      return parent.connection if parent && parent.connection
      client.connection
    end

    def url(data_center_id = self.data_center_id)
      "https://#{data_center_id}.qualtrics.com:443/API/v3/"
    end

    private

    def client
      @client ||= QualtricsAPI::Client.new(QualtricsAPI.api_token, QualtricsAPI.data_center_id)
    end
  end
end
