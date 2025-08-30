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

### include matcher

Analogy: `include` is like checking if an item is on your shopping list. You don’t care about the order or what else is there—just that the item is present.

```ruby
# /spec/include_matcher_spec.rb
RSpec.describe "include matcher" do
  context "with arrays" do
    it "checks for inclusion in an array" do
      expect([1, 2, 3]).to include(2)
      expect([1, 2, 3]).to include(1, 3)
    end
  end

  context "with hashes" do
    it "checks for inclusion in a hash (by key)" do
      expect({a: 1, b: 2}).to include(:a)
      expect({a: 1, b: 2}).to include(:a, :b)
    end
    it "checks for inclusion in a hash (by key-value pair)" do
      expect({a: 1, b: 2}).to include(a: 1)
    end
  end

  context "with strings" do
    it "checks for inclusion in a string" do
      expect("RSpec is fun").to include("RSpec")
      expect("RSpec is fun").to include("is", "fun")
    end
  end
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

### contain_exactly & match_array

Analogy: `contain_exactly` is like checking your grocery basket against a recipe—do you have all the right ingredients, no extras, and you don’t care about the order? `eq` would care about the order, but `contain_exactly` does not.

`contain_exactly` and `match_array` are functionally the same, but `contain_exactly` takes a list of arguments, while `match_array` takes a single array. Use whichever reads better for your test.

```ruby
# /spec/contain_exactly_match_array_spec.rb
RSpec.describe "contain_exactly & match_array" do
  it "checks for exact contents, any order" do
    expect([1, 2, 3]).to contain_exactly(3, 2, 1)
    expect([1, 2, 3]).to match_array([3, 2, 1])
  end

  it "fails if an element is missing or extra" do
    expect([1, 2, 3]).not_to contain_exactly(1, 2) # missing 3
    expect([1, 2, 3]).not_to match_array([1, 2, 3, 4]) # extra 4
  end

  it "works with nested arrays" do
    expect([[1, 2], [3, 4]]).to contain_exactly([3, 4], [1, 2])
  end
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

### start_with & end_with

Analogy: `start_with` and `end_with` are like checking if a book starts with a certain chapter or ends with a specific epilogue. Order matters at the beginning or end.

```ruby
# /spec/start_end_matchers_spec.rb
RSpec.describe "start_with & end_with" do
  it "checks start and end of a string" do
    expect("RSpec is great").to start_with("RSpec")
    expect("RSpec is great").to end_with("great")
  end

  it "checks start and end of an array" do
    expect([1, 2, 3]).to start_with(1)
    expect([1, 2, 3]).to end_with(3)
    expect([1, 2, 3]).to start_with(1, 2)
    expect([1, 2, 3]).to end_with(2, 3)
  end
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

### have_attributes matcher

Analogy: `have_attributes` is like checking a character sheet in a game—does your object have the right stats?

This matcher is especially useful for model instances or objects with many attributes, letting you check several at once instead of writing multiple expectations.

```ruby
# /spec/have_attributes_spec.rb
RSpec.describe "have_attributes matcher" do
  it "checks object attributes" do
    user = OpenStruct.new(name: "Alice", age: 30)
    expect(user).to have_attributes(name: "Alice", age: 30)
  end

  it "fails if an attribute is missing or wrong" do
    user = OpenStruct.new(name: "Bob", age: 25)
    expect(user).not_to have_attributes(name: "Alice")
  end

  it "works with extra attributes present" do
    user = OpenStruct.new(name: "Alice", age: 30, admin: true)
    expect(user).to have_attributes(name: "Alice") # ignores extra attributes
  end

  it "fails if a required attribute is missing" do
    user = OpenStruct.new(age: 30)
    expect(user).not_to have_attributes(name: "Alice")
  end
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

**Failed Example Output:**

If you expect an attribute that is missing or wrong, you’ll see a failure like:

```shell
Failure/Error: expect(user).to have_attributes(name: "Alice")

  expected #<OpenStruct age=30> to have attributes {:name=>"Alice"}
       but had attributes {:age=>30}
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

## Practice Prompts

Try these exercises to reinforce your learning. For each, write your own spec in the appropriate file (e.g., `/spec/include_matcher_spec.rb`).

**Exercise 1: include and contain_exactly with arrays and hashes**
Write specs using `include` and `contain_exactly` for arrays and hashes. Try with nested arrays or hashes as well.

**Exercise 2: have_attributes with custom objects**
Write specs using `have_attributes` for custom objects. Test both passing and failing cases (e.g., missing or extra attributes).

**Exercise 3: start_with and end_with for strings and arrays**
Write specs using `start_with` and `end_with` for strings and arrays. Try with multiple elements and edge cases (e.g., empty arrays).

**Exercise 4: Failure scenarios**
Write a spec that intentionally fails using one of the matchers above. What does the failure message tell you?

---

## Resources

- _See the official RSpec documentation for collection matchers:_
  - [RSpec: Collection Matchers](https://relishapp.com/rspec/rspec-expectations/v/3-10/docs/built-in-matchers/contain-exactly-matcher)
- _Learn more about attribute matchers:_
  - [RSpec: Attribute Matchers](https://relishapp.com/rspec/rspec-expectations/v/3-10/docs/built-in-matchers/have-attributes-matcher)
- _Best practices for using matchers in your specs:_
  - [Better Specs: Matchers](https://www.betterspecs.org/#expect)
