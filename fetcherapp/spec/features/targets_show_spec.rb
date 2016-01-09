require 'rails_helper'

describe 'Test the display of the targets' do
  it 'Show', js: true do
    visit targets_path
    save_screenshot("screenshot.jpg")
  end

end