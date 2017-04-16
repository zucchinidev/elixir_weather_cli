defmodule WeatherCliTest do
  use ExUnit.Case
  doctest WeatherCli
  import WeatherCli.CLI, only: [
    parser_args: 1,
    get_city_id_from_city_name: 1
  ]

  test ":help returned by option parsing with -h and --help options" do
    assert parser_args(["-h", "anything"]) == :help
    assert parser_args(["--help", "anything"]) == :help
  end

  test "one values returned if one given" do
    assert parser_args(["madrid"]) == { "madrid" }
  end

  test "transform city name to city id" do
    assert get_city_id_from_city_name({ "madrid" }) == {"madrid"}
  end
end
