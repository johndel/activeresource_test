require 'rails_helper'

describe Target do
  it 'returns true' do
    target = Target.create(name: "test")
    expect(target.name).to eq("test")
  end
end