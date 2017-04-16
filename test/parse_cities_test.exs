defmodule WeatherCli.ParseCitiesTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import WeatherCli.ParseCities, only: [
    find_city: 1,
    find_city_from_line_file: 2,
    handle_find: 1,
    handle_parse: 1,
    get_file_path: 0
  ]

  test "show message City not found with option with nil value" do
    result = capture_io(fn ->
      handle_find(nil)
    end)

    assert result == "City not found\n"
  end


  test "A run-time error is thrown by inserting an invalid json" do
    invalid_json = get_mock_city_in_string_format() <> "{{ddd}}"
    assert_raise RuntimeError, "Upps, an error has occurred", fn ->
      handle_find(invalid_json)
    end
  end

  test "a city is returned when we pass as a valid json parameter" do
    assert handle_find(get_mock_city_in_string_format()) == get_mock_city()
  end

  test "a city is returned when we search a valid city" do
    assert find_city("madrid") == get_mock_city()
  end

  defp get_mock_city do
    %{
      "name" => "Madrid",
      "country" => "ES",
      "_id" => 6359304,
      "coord" => %{
                    "lat" => 40.489349,
                    "lon" => -3.68275
                 }
    }
  end

  defp get_mock_city_in_string_format do
    "{\"name\":\"Madrid\",\"country\":\"ES\",\"coord\":{\"lon\":-3.68275,\"lat\":40.489349},\"_id\":6359304}"
  end
end
