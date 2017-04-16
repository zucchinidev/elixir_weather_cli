defmodule WeatherCli.ParseCities do

  def init_search(query) do
    find_city(query)
  end
  
  def find_city(query) do
    File.stream!(get_file_path())
      |> Enum.find(&find_city_from_line_file(&1, query))
      |> handle_find
  end

  def find_city_from_line_file(line, city) do
    map_city = Poison.Parser.parse!(line)
    String.downcase(city) == String.downcase(map_city["name"])
  end

  def handle_find(nil), do: IO.puts "City not found"
  def handle_find(city) do
    city
      |> Poison.Parser.parse
      |> handle_parse
  end

  def handle_parse({:ok, city}), do: city
  def handle_parse({:error, _}) do
    raise "Upps, an error has occurred"
  end

  defp get_file_path do
    root_dir = File.cwd!()
    data_dir = Path.join(~w(#{root_dir} lib weather_cli data))
    Path.join(~w(#{data_dir} city.list.json))
  end
end