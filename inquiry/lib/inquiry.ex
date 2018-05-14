defmodule Inquiry do
  @moduledoc """
  Inquiry allows you to extract data from a nested data structura
  like the ones you get from parsing a JSON.

  I allows you to use strings as: key_in_map_one.key2.0 to get data
  from the nested structures.

  The nested structures support by now Lists and Maps
  """

  @doc """
  Hello world.

  ## Examples

      iex> Inquiry.inquiry(%{hello: ['world', "me"]}, "hello.0")
      'world'

  """
  def inquiry(data, query) do
    decomposed_query = String.split(query, ".")
    _inquiry(data, decomposed_query)
  end

  def _inquiry(data, query) do
    data
  end
end
