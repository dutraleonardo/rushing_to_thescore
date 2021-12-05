defmodule RushingToThescore.Helpers.DataNormalizer do
  def stats_converter(input) do
    Enum.map(input, fn map ->
      Map.put(map, "Lng", convert_to_string(map["Lng"]))
      |> Map.put("Yds", convert_to_float(map["Yds"]))
    end)
  end

  defp convert_to_string(value) when is_integer(value) do
    Integer.to_string(value)
  end

  defp convert_to_string(value), do: value

  defp convert_to_float(value) when is_binary(value) do
    {value, _} =
      value
      |> String.replace(",", "")
      |> Integer.parse()

    value
  end

  defp convert_to_float(value), do: value
end
