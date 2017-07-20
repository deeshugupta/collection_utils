require "spec_helper"

RSpec.describe CollectionUtils::HashDeserializedObject do
  before(:each) do
    hash = {
      name: "test",
      age: 26,
      EmployeeCode: 1
    }
    @obj = CollectionUtils::HashDeserializedObject.new(hash)
  end
  it "access object value" do
    expect(@obj.age).to be 26
    expect(@obj.name).to eq("test")
    expect(@obj.employee_code).to be 1
  end

  it "test get_serialized_object" do
    @obj.insert(:email, "test@test.test")
    expect(@obj.email).to eq("test@test.test")
    expect(@obj.get_serialized_object).to eq({
      name: "test",
      age: 26,
      EmployeeCode: 1,
      email: "test@test.test"
    })
  end

  it "change the name accordingly" do
    @obj.insert(:EmailAddress, "test@test.test")
    expect(@obj.email_address).to eq("test@test.test")
    expect(@obj.get_serialized_object).to eq({
      name: "test",
      age: 26,
      EmployeeCode: 1,
      EmailAddress: "test@test.test"
    })
  end

end
