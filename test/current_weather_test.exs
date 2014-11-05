defmodule CurrentWeatherTest do
  use ExUnit.Case

  test "weather for Cuiaba is returned" do
    assert CurrentWeather.weather("455829") > 0
  end
end
