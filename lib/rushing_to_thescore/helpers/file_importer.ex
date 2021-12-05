defmodule RushingToThescore.Helpers.FileImporter do
  def json_importer(filename) do
    with {:ok, body} <- File.read(filename),
         {:ok, json} <- Jason.decode(body) do
      {:ok, RushingToThescore.Helpers.DataNormalizer.stats_converter(json)}
    else
      {:error, error} -> {:error, error}
    end
  end
end
