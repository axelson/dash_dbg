defmodule DashDbgWeb.PageController do
  use DashDbgWeb, :controller
  require Logger

  def home(conn, _params) do
    # url = "http://localhost:8000/capture.ppm"
    url = "http://inky.local/capture.ppm"

    capture_ppm =
      case Req.get(url) do
        {:ok, resp} ->
          resp.body

        error ->
          Logger.warn("Error fetching capture: #{inspect(error)}")
          nil
      end

    conn
    |> Plug.Conn.put_resp_content_type("image/png")
    |> Plug.Conn.send_resp(200, capture_ppm)

    # render(conn, :home, layout: false)
  end
end
