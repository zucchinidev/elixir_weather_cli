#!/usr/bin/env bash
# put your api key in weather_api_key.env file
api_key=$(cat weather_api_key.env);
export WEATHER_API_KEY=$api_key;
