describe ContactType do
  describe "name" do
    it { should_not accept_values_for(:name, nil, "") }
  end
end
