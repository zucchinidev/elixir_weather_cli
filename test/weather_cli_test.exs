defmodule WeatherCliTest do
  use ExUnit.Case
  import WeatherCli.CLI, only: [
    parser_args: 1,
    get_city_from_city_name: 1
  ]

  test ":help returned by option parsing with -h and --help options" do
    assert parser_args(["-h", "anything"]) == :help
    assert parser_args(["--help", "anything"]) == :help
  end

  test "one values returned if one given" do
    assert parser_args(["madrid"]) == "madrid"
  end

  test "should return a city map search by city name" do
    city = get_city_from_city_name("jjdjdjd")
    assert city ==
  end
end
