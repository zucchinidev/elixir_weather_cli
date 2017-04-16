defmodule WeatherCli.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to the various functions
  that end up generating a table of weather result of a city
  """
  def run(argv) do
    argv 
      |> parser_args
      |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.
  Otherwise it is a city name or city id. Return a tuple of `{ city_id }`,
  or `:help` if help was given.
  """
  def parser_args(argv) do
    parse = OptionParser.parse(argv, switcher: [help: :boolean],
                                     aliases:  [h: :help       ])
    case parse do
      { [help: true], _, _ } -> :help
      { _ , [ city_id ], _ } -> { city_id }
      _ -> :help
    end
  end
  
  def process(:help) do
    IO.puts """
    usage: weather_cli <city_id> | <city_name>
    """
    System.halt(0)
  end

  def process({city_id}), do: get_city_id_from_city_name({city_id})

  def get_city_id_from_city_name({ city_id }) do
    { city_id }
  end
end