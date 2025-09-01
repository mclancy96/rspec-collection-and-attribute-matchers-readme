# RSpec: Collection & Attribute Matchers

Welcome to Lesson 14! This lesson is all about RSpec's collection and attribute matchers—tools that let you write expressive, readable specs for arrays, hashes, sets, and objects with attributes. These matchers help you check if a collection contains certain elements, if it matches exactly, if an object has specific attributes, or if a string/array starts or ends with something. We'll cover what they are, why they're useful, when to use each, and show you lots of examples (with output) so you can see them in action.

---

## Why Use Collection & Attribute Matchers?

- **Expressiveness:** They let you write specs that read like English, making your intent clear.
- **Precision:** You can check for exact contents, order, or presence/absence of elements.
- **Robustness:** They help you avoid brittle tests that break when the order changes but the data is correct.
- **Real-world scenarios:** Useful for testing APIs, database queries, service objects, and more.

---

## Common Scenarios

- Checking if an API response includes certain keys or values
- Verifying a model returns the right set of records
- Making sure an object has the right attributes after initialization
- Testing that a string or array starts/ends with the expected value

---

## Overview of Collection & Attribute Matchers

### Collection Matchers

- `include(*expected)` — Passes if the actual collection includes the expected element(s)
- `contain_exactly(*expected)` — Passes if the actual collection contains all and only the expected elements, in any order
- `match_array(array)` — Same as `contain_exactly`, but takes a single array argument
- `start_with(*expected)` — Passes if the actual string or array starts with the expected value(s)
- `end_with(*expected)` — Passes if the actual string or array ends with the expected value(s)

### Attribute Matchers

- `have_attributes(expected)` — Passes if the object has the specified attributes with the given values

---

## Detailed Examples & Output

### include matcher (Library domain)

Analogy: `include` is like checking if a book is on your library shelf. You don’t care about the order or what else is there—just that the book is present.

```ruby
# /spec/collection_spec.rb
it 'includes a book with a specific title' do
  expect(library.titles).to include("Ruby 101")
end
```

**Output:**

```shell
include matcher
  checks for inclusion in an array
  checks for inclusion in a hash (by key)
  checks for inclusion in a string

Finished in 0.01 seconds (files took 0.1 seconds to load)

3 examples, 0 failures
```

---

### contain_exactly & match_array (Library domain)

Analogy: `contain_exactly` is like checking your library’s catalog—do you have all the right books, no extras, and you don’t care about the order?

```ruby
# /spec/collection_spec.rb
it 'contains exactly the right titles, any order' do
  expect(library.titles).to contain_exactly("Ruby 101", "RSpec Mastery", "Gardening Basics")
end

it 'matches array of tags for a book, order does not matter' do
  expect(book1.tags).to match_array(["beginner", "ruby"])
end
```

**Why not use `eq`?**
`eq` checks for exact order and contents. Use `contain_exactly` or `match_array` when order doesn’t matter.

**Output:**

```shell
contain_exactly & match_array
  checks for exact contents, any order

Finished in 0.01 seconds (files took 0.1 seconds to load)
1 example, 0 failures
```

---

### start_with & end_with (Library domain)

Analogy: `start_with` and `end_with` are like checking if your library’s genres start with “Programming” and end with “Outdoors.”

```ruby
# /spec/collection_spec.rb
it 'starts with the first two genres for a book' do
  expect(book2.genres).to start_with("Programming", "Testing")
end

it 'ends with the last two genres in the library genres list' do
  expect(library.genres).to end_with("Hobby", "Outdoors")
end
```

**Output:**

```shell
start_with & end_with
  checks start and end of a string
  checks start and end of an array

Finished in 0.01 seconds (files took 0.1 seconds to load)
2 examples, 0 failures
```

---

### have_attributes matcher (Library domain)

Analogy: `have_attributes` is like checking a book’s details—does it have the right title, author, and page count?

```ruby
# /spec/collection_spec.rb
it 'has attributes for a book' do
  expect(book1).to have_attributes(title: "Ruby 101", author: "Alice", pages: 200)
end

it 'finds all books by a specific author' do
  expect(library.find_by_author("Alice")).to all(have_attributes(author: "Alice"))
end

it 'checks that all books have more than 100 pages' do
  expect(library.books).to all(have_attributes(pages: be > 100))
end
```

**Output:**

```shell
have_attributes matcher
  checks object attributes
  fails if an attribute is missing or wrong
  works with extra attributes present
  fails if a required attribute is missing

Finished in 0.01 seconds (files took 0.1 seconds to load)
4 examples, 0 failures
```

```ruby
# /spec/collection_spec.rb
it 'fails if a book is missing a required attribute (pending)' do
  pending("Student: Implement a test for missing attribute using have_attributes")
  raise "Unimplemented pending spec"
end

it 'is pending: test for exact genres in a book (student to implement)' do
  pending("Student: Write a test using contain_exactly for genres")
  raise "Unimplemented pending spec"
end

it 'checks that a book has extra attributes present' do
  book = Book.new(title: "Extra", author: "Eve", genres: ["Fiction"], pages: 150, published_year: 2021, tags: ["fun", "short"])
  expect(book).to have_attributes(title: "Extra")
end
```

---

## When to Use Each Matcher

- Use `include` for checking presence of elements/keys/values in collections or substrings in strings.
- Use `contain_exactly` or `match_array` when you care about the exact contents but not the order. (If order matters, use `eq`.)

- Use `start_with`/`end_with` for strings or arrays when order matters at the beginning or end.
- Use `have_attributes` for objects with multiple attributes you want to check at once, especially for model instances or complex objects.

---

## Common Pitfalls

- `include` on a hash checks keys, not values (unless you use key-value pairs).
- `contain_exactly` and `match_array` ignore order—use `eq` for strict order.
- `have_attributes` only checks the attributes you specify, not all attributes.
- `contain_exactly` and `match_array` do not work with hashes (only arrays or sets).

---

---

## Hands-On Student Instructions

This lesson repo is set up for you to get hands-on practice with RSpec's collection and attribute matchers using a real Ruby domain (Library/Book). To get started:

1. **Fork and Clone** this repository to your own GitHub account and local machine.
2. **Install dependencies:**

    ```sh
    bundle install
    ```

3. **Run the specs:**

    ```sh
    bin/rspec
    ```

4. **Explore the code:**

   - The main domain code is in `lib/library.rb`.
   - The robust example specs are in `spec/collection_spec.rb`.

5. **Implement the pending specs:**

   - There are at least two pending specs marked with `pending` in `spec/collection_spec.rb`.
   - Your task: Remove the `pending` line and implement the expectation so the spec passes.

6. **Experiment:**

   - Try adding your own examples using the matchers covered in this lesson.
   - Make the specs fail on purpose to see the error messages and learn from them.

All specs should pass except the pending ones. When you finish, all specs should be green!

---

## Resources

- _See the official RSpec documentation for collection matchers:_
  - [RSpec: Collection Matchers](https://relishapp.com/rspec/rspec-expectations/v/3-10/docs/built-in-matchers/contain-exactly-matcher)
- _Learn more about attribute matchers:_
  - [RSpec: Attribute Matchers](https://relishapp.com/rspec/rspec-expectations/v/3-10/docs/built-in-matchers/have-attributes-matcher)
- _Best practices for using matchers in your specs:_
  - [Better Specs: Matchers](https://www.betterspecs.org/#expect)
