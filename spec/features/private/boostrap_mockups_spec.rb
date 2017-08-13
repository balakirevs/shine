require 'rails_helper'

feature 'bootstrap' do

  scenario 'step one of our grid' do
    get_to_mockups_page
    screenshot! filename: 'bootstrap-first-columns.png', selector: '#first-columns'
  end

  scenario 'use the grid on a form' do
    get_to_mockups_page
    screenshot! filename: 'bootstrap-customer-info-grid.png', selector: '#customer-info-grid'
  end

  scenario 'grids. grids everywhere' do
    get_to_mockups_page
    screenshot! filename: 'bootstrap-all-grid.png', selector: '#all-grid'
  end

  scenario 'panel example' do
    get_to_mockups_page
    screenshot! filename: 'bootstrap-panel-example.png', selector: '#panel-example'
  end

  scenario 'panels' do
    get_to_mockups_page
    screenshot! filename: 'bootstrap-panels.png', selector: '#panels'
  end

  scenario 'labels' do
    get_to_mockups_page
    screenshot! filename: 'bootstrap-labels.png', selector: '#labels'
  end
end
