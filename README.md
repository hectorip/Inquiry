# Inquiry

Elixir library to extract a specific value from a nested data structure in a query-like style.

This intended to help you extract a specicif value without having to write a lot of boilerplate code, like pattern matching, case statements, etc.

## Examples


```elixir
iex> Inquiry.inquiry([1, 2, 3], "0")
