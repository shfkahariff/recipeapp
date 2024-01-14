require "test_helper"

class LeaveBalancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @leave_balance = leave_balances(:one)
  end

  test "should get index" do
    get leave_balances_url
    assert_response :success
  end

  test "should get new" do
    get new_leave_balance_url
    assert_response :success
  end

  test "should create leave_balance" do
    assert_difference("LeaveBalance.count") do
      post leave_balances_url, params: { leave_balance: { balance: @leave_balance.balance, leavetype: @leave_balance.leavetype } }
    end

    assert_redirected_to leave_balance_url(LeaveBalance.last)
  end

  test "should show leave_balance" do
    get leave_balance_url(@leave_balance)
    assert_response :success
  end

  test "should get edit" do
    get edit_leave_balance_url(@leave_balance)
    assert_response :success
  end

  test "should update leave_balance" do
    patch leave_balance_url(@leave_balance), params: { leave_balance: { balance: @leave_balance.balance, leavetype: @leave_balance.leavetype } }
    assert_redirected_to leave_balance_url(@leave_balance)
  end

  test "should destroy leave_balance" do
    assert_difference("LeaveBalance.count", -1) do
      delete leave_balance_url(@leave_balance)
    end

    assert_redirected_to leave_balances_url
  end
end
