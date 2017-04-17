defmodule WeatherCli.Http do
  @api_key Application.get_env(:weather_cli, :API_KEY)
  @api_url Application.get_env(:weather_cli, :weather_url)

 require Logger

  def fetch_city_weather(city) do
#  IO.inspect city
    url = weather_url(city["_id"])
    Logger.info "Fetching city name #{city["name"]}"
    HTTPoison.get(url)
      |> handle_response
  end
  
  def handle_response({:ok, %{status_code: 200, body: body}}) do
    weather = Poison.Parser.parse!(body)
    IO.puts get_header()
    IO.puts get_separator()
    IO.puts get_body(weather)
  end

  def handle_response({:error, %{status_code: status, body: body}}) do
    Logger.error "Error status: #{status} returned"
  end

  def get_header() do
    headers = ["Name", "Humedad", "Temp.Max", "Temp.Min", "Description", "Viento"]
    format(headers)
  end

  def get_body(weather) do
    main = Map.get(weather, "main")
    [w | _ ] = weather["weather"]
    wind = weather["wind"]
    body = [
      weather["name"],
      main["humidity"],
      main["temp_max"],
      main["temp_min"],
      w["description"],
      "Deg: #{wind["deg"]} - Speed: #{wind["speed"]}"
    ]
    Enum.map(body, &to_string/1) |> format()
  end

  def get_separator do
     format ["", "", "", "", "", ""], "-"
  end

  defp format(cells, padding_character \\ " ") do
     Enum.map(cells, &String.pad_trailing(&1, 15, padding_character))
  end

  defp weather_url(city_id) do
    "#{@api_url}#{@api_key}&id=#{city_id}"
  end
end