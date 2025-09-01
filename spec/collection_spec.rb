
require 'library'

RSpec.describe 'Library and Book collection/attribute matchers' do
  let(:book1) { Book.new(title: "Ruby 101", author: "Alice", genres: ["Programming", "Education"], pages: 200, published_year: 2020, tags: ["ruby", "beginner"]) }
  let(:book2) { Book.new(title: "RSpec Mastery", author: "Bob", genres: ["Programming", "Testing"], pages: 350, published_year: 2022, tags: ["rspec", "advanced"]) }
  let(:book3) { Book.new(title: "Gardening Basics", author: "Alice", genres: ["Hobby", "Outdoors"], pages: 120, published_year: 2018, tags: ["plants"]) }
  let(:library) { Library.new([book1, book2, book3]) }

  it 'includes a book with a specific title' do
    expect(library.titles).to include("Ruby 101")
  end

  it 'includes all genres from all books' do
    expect(library.genres).to include("Programming", "Hobby")
  end

  it 'contains exactly the right titles, any order' do
    expect(library.titles).to contain_exactly("Ruby 101", "RSpec Mastery", "Gardening Basics")
  end

  it 'matches array of tags for a book, order does not matter' do
    expect(book1.tags).to match_array(["beginner", "ruby"])
  end

  it 'starts with the first two genres for a book' do
    expect(book2.genres).to start_with("Programming", "Testing")
  end

  it 'ends with the last two genres in the library genres list' do
    # The actual order from Library#genres is ["Programming", "Education", "Testing", "Hobby", "Outdoors"]
    expect(library.genres).to end_with("Hobby", "Outdoors")
  end

  it 'has attributes for a book' do
    expect(book1).to have_attributes(title: "Ruby 101", author: "Alice", pages: 200)
  end

  it 'finds all books by a specific author' do
    expect(library.find_by_author("Alice")).to all(have_attributes(author: "Alice"))
  end

  it 'checks that all books have more than 100 pages' do
    expect(library.books).to all(have_attributes(pages: be > 100))
  end

  it 'checks that the library includes a book with a specific tag' do
    expect(library.books.map(&:tags).flatten).to include("rspec")
  end

  it 'fails if a book is missing a required attribute (pending)' do
    pending("Student: Implement a test for missing attribute using have_attributes")
    raise "Unimplemented pending spec"
    # incomplete_book = Book.new(title: "Mystery", author: nil, genres: [], pages: 100, published_year: 2023)
    # expect(incomplete_book).not_to have_attributes(author: "Someone")
  end

  it 'is pending: test for exact genres in a book (student to implement)' do
    pending("Student: Write a test using contain_exactly for genres")
    raise "Unimplemented pending spec"
    # Example: expect(book3.genres).to contain_exactly("Hobby", "Outdoors")
  end

  it 'checks that the library titles start with a specific book' do
    expect(library.titles).to start_with("Ruby 101")
  end

  it 'checks that the library titles end with a specific book' do
    expect(library.titles).to end_with("Gardening Basics")
  end

  it 'checks that the library does not include a non-existent book' do
    expect(library.titles).not_to include("Nonexistent Book")
  end

  it 'checks that a book has extra attributes present' do
    book = Book.new(title: "Extra", author: "Eve", genres: ["Fiction"], pages: 150, published_year: 2021, tags: ["fun", "short"])
    expect(book).to have_attributes(title: "Extra")
  end
end
