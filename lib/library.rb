# frozen_string_literal: true

# Domain: Library/Book (unique, not previously used)
# This class represents a Book with various attributes for attribute matchers.
class Book
  attr_accessor :title, :author, :genres, :pages, :published_year, :tags

  def initialize(title:, author:, genres: [], pages:, published_year:, tags: [])
    @title = title
    @author = author
    @genres = genres
    @pages = pages
    @published_year = published_year
    @tags = tags
  end
end

# This class represents a Library, which is a collection of books.
class Library
  attr_reader :books

  def initialize(books = [])
    @books = books
  end

  def add_book(book)
    @books << book
  end

  def find_by_author(author)
    @books.select { |book| book.author == author }
  end

  def genres
    @books.flat_map(&:genres).uniq
  end

  def titles
    @books.map(&:title)
  end
end
