require 'test_helper'

class GrantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grant = grants(:one)
  end

  test "should get index" do
    get grants_url
    assert_response :success
  end

  test "should get new" do
    get new_grant_url
    assert_response :success
  end

  test "should create grant" do
    assert_difference('Grant.count') do
      post grants_url, params: { grant: { amount: @grant.amount, fiscal_year: @grant.fiscal_year, grantStatusID: @grant.grantStatusID, grant_type: @grant.grant_type, location: @grant.location, nh_served: @grant.nh_served, organization: @grant.organization, project: @grant.project, strategic_priority: @grant.strategic_priority, strategic_results: @grant.strategic_results, total_served: @grant.total_served } }
    end

    assert_redirected_to grant_url(Grant.last)
  end

  test "should show grant" do
    get grant_url(@grant)
    assert_response :success
  end

  test "should get edit" do
    get edit_grant_url(@grant)
    assert_response :success
  end

  test "should update grant" do
    patch grant_url(@grant), params: { grant: { amount: @grant.amount, fiscal_year: @grant.fiscal_year, grantStatusID: @grant.grantStatusID, grant_type: @grant.grant_type, location: @grant.location, nh_served: @grant.nh_served, organization: @grant.organization, project: @grant.project, strategic_priority: @grant.strategic_priority, strategic_results: @grant.strategic_results, total_served: @grant.total_served } }
    assert_redirected_to grant_url(@grant)
  end

  test "should destroy grant" do
    assert_difference('Grant.count', -1) do
      delete grant_url(@grant)
    end

    assert_redirected_to grants_url
  end
end
