feature 'Adding tags' do

  scenario 'add a single tag to a new link' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tags',  with: 'education'

    click_button 'submit'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education')
  end

end
