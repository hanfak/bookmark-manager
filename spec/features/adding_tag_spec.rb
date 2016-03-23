feature 'add tag' do
  scenario 'create a tag and connect with link' do
    visit 'links/new'
    fill_in(:url, with: "http://www.google.com")
    fill_in(:title, with: "Google")
    fill_in(:tags, with: "search")
    click_button "submit"

    link = Link.first
    expect(link.tags.map(&:name)).to include('search')
  end

  scenario 'add mulitple tags to a link' do
    visit 'links/new'
    fill_in(:url, with: "http://www.google.com")
    fill_in(:title, with: "Google")
    fill_in(:tags, with: "search overload")
    click_button "submit"

    link = Link.first
    expect(link.tags.map(&:name)).to include('search', 'overload')
  end
end
