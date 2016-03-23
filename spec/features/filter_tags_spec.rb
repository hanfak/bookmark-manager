feature 'filter' do
  scenario 'links by tag' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy', tags: [Tag.first_or_create(name: 'education')])

    Link.create(url: 'http://www.google.com', title: 'Google', tags: [Tag.first_or_create(name: 'search')])

    Link.create(url: 'http://www.tobenna.com', title: 'I have a headache', tags: [Tag.first_or_create(name: 'help')])

    Link.create(url: 'http://www.lovemelongtime.com', title: 'Fun with Tobenna', tags: [Tag.first_or_create(name: 'help')])

    visit '/tags/help'
    within 'ul#links' do
      expect(page).to have_content("I have a headache")
      expect(page).to have_content("Fun with Tobenna")
      expect(page).not_to have_content('Makers Academy')
      expect(page).not_to have_content('Code.org')
    end
  end
end
