defmodule ParallelSerialWeb.PageController do
  use ParallelSerialWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create_requests(q) do
  	[
  		{:ated, "http://api.atnd.org/events/?keyword=#{q}&format=json"},
  		{:connpass, "http://connpass.com/api/v1/event/?keyword=#{q}"},
  		{:doorkeeper, "http://api.doorkeeper.jp/events/?q=#{q}"},
  		{:zusaar, "http://www.zusaar.com/api/event/?keyword=#{q}"}
  	]
  end

  def get_response(request) do
  	{site, url} = request
  	HTTPoison.start
  	result = HTTPoison.get! url
  	case result do
  		%{status_code: 200, body: body} -> {site, Poison.decode!(body)}
  		%{status_code: code} -> {site, nil}
  	end
  end

  def parse_response(response) do
  	case response do
  		{:atnd, json} -> Map.get(json, "events") |> Enum.map(&Map.get(&1, "event"))
  		{:connpass, json} -> Map.get(json, "events")
  		{:doorkeeper, json} -> json |> Enum.map(&(Map.get(&1, "event")))
  		{:zusaar, json} -> Map.get(json, "event")
  	end
  end

  def serial_search(conn, %{"q" => q}) do
  	results = create_requests(q)
  	|> Enum.map(&get_response/1)
  	|> Enum.map(&parse_response/1)
  	|> List.flatten
  	json conn, results
  end

  def parallel_search(conn, %{"q" => q}) do
  	results = create_requests(q)
  	|> Enum.map(&Task.async(fn -> get_response(&1) end))
  	|> Enum.map(&Task.await(&1, 10_000))
  	|> Enum.map(&parse_response/1)
  	|> List.flatten
  	json conn, results
  end
end
