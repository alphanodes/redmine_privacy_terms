require File.expand_path('../test_helper', __dir__)

class RoutingTest < Redmine::RoutingTest
  test 'terms' do
    should_route 'GET /terms/accept' => 'terms#accept'
    should_route 'GET /terms/reject' => 'terms#reject'
    should_route 'GET /terms/reset' => 'terms#reset'
  end
end
