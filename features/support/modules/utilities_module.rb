module UtilitiesModule
  def verify_both_results_are_same? exp_val, act_val
    fail "Expected - #{exp_val} is NOT same as Actual - #{act_val}" unless exp_val == act_val
  end

  def verify_expected_value_exists? act_val, exp_val
    fail "Expected value - #{exp_val} does not exist in Actual value - #{act_val}" unless act_val.include? exp_val
  end

end