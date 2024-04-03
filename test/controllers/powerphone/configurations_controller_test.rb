require "test_helper"

module Powerphone
  class ConfigurationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get show" do
      get configuration_url
      assert_response :success
    end

    test "should get show as root" do
      get root_url
      assert_response :success
    end

    test "should put update" do
      put configuration_url
      assert_response :not_acceptable
    end

    test "should patch update" do
      patch configuration_url
      assert_response :not_acceptable
    end
  end
end
