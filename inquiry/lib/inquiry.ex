defmodule Inquiry do
  @moduledoc """
  Inquiry allows you to extract data from a nested data structure
  like the ones you get from parsing a JSON.

  It allows you to use strings as: key_in_map_one.key2.0 to get data
  from the nested structures.

  The nested structures supported by now are Lists and Maps with string
  keys, we're working in a new version that suppports atoms.
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

  def _inquiry(data, []), do: data

  def _inquiry([], _), do: nil
  def _inquiry(data = [_|_], [current_query|rest]) do
    {index, _} = Integer.parse(current_query)
    _inquiry(Enum.at(data, index), rest)
  end
  def _inquiry(data, [current_query|rest]), do: data |> Map.get(current_query) |> _inquiry(rest) # lacks non-string keys querying
end
