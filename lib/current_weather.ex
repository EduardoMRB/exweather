defmodule CurrentWeather do
  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlAttribute, Record.extract(:xmlAttribute, from_lib: "xmerl/include/xmerl.hrl")

  def weather(id) do
    id |> get |> extract_temp
  end

  defp extract_temp(body) do
    {xml, _rest} = :xmerl_scan.string(:erlang.bitstring_to_list(body))
    [ condition ] = :xmerl_xpath.string('/rss/channel/item/yweather:condition/@temp', xml)
    xmlAttribute(condition, :value)
  end

  defp get(id) do
    {:ok, 200, _headers, client} = :hackney.get(url_for(id))
    {:ok, body} = :hackney.body(client)
    body
  end

  defp url_for(id) do
    "http://weather.yahooapis.com/forecastrss?w=#{id}"
  end
end
