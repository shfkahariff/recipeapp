require "application_system_test_case"

class LeaveBalancesTest < ApplicationSystemTestCase
  setup do
    @leave_balance = leave_balances(:one)
  end

  test "visiting the index" do
    visit leave_balances_url
    assert_selector "h1", text: "Leave balances"
  end

  test "should create leave balance" do
    visit leave_balances_url
    click_on "New leave balance"

    fill_in "Balance", with: @leave_balance.balance
    fill_in "Leavetype", with: @leave_balance.leavetype
    click_on "Create Leave balance"

    assert_text "Leave balance was successfully created"
    click_on "Back"
  end

  test "should update Leave balance" do
    visit leave_balance_url(@leave_balance)
    click_on "Edit this leave balance", match: :first

    fill_in "Balance", with: @leave_balance.balance
    fill_in "Leavetype", with: @leave_balance.leavetype
    click_on "Update Leave balance"

    assert_text "Leave balance was successfully updated"
    click_on "Back"
  end

  test "should destroy Leave balance" do
    visit leave_balance_url(@leave_balance)
    click_on "Destroy this leave balance", match: :first

    assert_text "Leave balance was successfully destroyed"
  end
end
