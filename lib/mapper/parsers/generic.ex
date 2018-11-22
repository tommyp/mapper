defmodule Parsers.Generic do

  def run(url) do
    HTTPoison.start

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        process(body)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  defp process(body) do
    body
    |> find_address
  end

  defp find_address(body) do
    body.to_list
    |> Enum.find(fn(x) ->
      Regex.match?(~r/[A-Z]{1,2}[0-9]{1,2}\s?[0-9]{1,2}[A-Z]{1,2}/, x)
    end)
  end
end
