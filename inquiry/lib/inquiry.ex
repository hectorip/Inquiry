defmodule Inquiry do
  @moduledoc """
  Inquiry allows you to extract data from a nested data structure
  like the ones you get from parsing a JSON.

  It allows you to use strings as: `person.adresses.0.street` to get data
  from the nested structures.

  The nested structures supported by now are Lists and Maps with string
  keys, we're working in a new version that supports atoms.
  """

  @doc """
  Get the data from the specified path, returns the default or :nil

  ## Examples

      iex> Inquiry.inquiry(%{"hello" => ['world', "me"]}, "hello.0")
      'world'

      iex> Inquiry.inquiry(%{"hello" => ["zero", "one", "two", %{"yes" => true}]}, "hello.3.yes")
      true
  """

  def inquiry(data, query, default \\ :nil) do
    decomposed_query = String.split(query, ".")

    _inquiry(data, decomposed_query) || default
  end

  # When there's no query
  def _inquiry(data, []), do: data

  # When there's an empty list or not found data
  def _inquiry([], _), do: nil
  def _inquiry(nil,_), do: nil

  # When data is a non-empty list
  def _inquiry(data = [_|_], [current_query|rest]) do
    {index, _} = Integer.parse(current_query)
    _inquiry(Enum.at(data, index), rest)
  end

  # When data is anything else, but we only expect maps
  def _inquiry(data, [current_query|rest]), do: data |> Map.get(current_query) |> _inquiry(rest) # lacks non-string keys querying
end
