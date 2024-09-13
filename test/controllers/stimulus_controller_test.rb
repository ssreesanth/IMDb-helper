require "test_helper"

class StimulusControllerTest < ActionDispatch::IntegrationTest
  test "should get imdb" do
    get stimulus_imdb_url
    assert_response :success
  end
end
