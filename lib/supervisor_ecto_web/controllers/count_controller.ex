defmodule SupervisorEctoWeb.CountController do
  use SupervisorEctoWeb, :controller

  alias SupervisorEcto.Json
  alias SupervisorEcto.Json.Count

  action_fallback SupervisorEctoWeb.FallbackController

  def index(conn, _params) do
    # インクリメントする．
    SupervisorEcto.Counter.increment()
    counts = Json.list_counts()
    render(conn, "index.json", counts: counts)
  end

  def create(conn, %{"count" => count_params}) do
    with {:ok, %Count{} = count} <- Json.create_count(count_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", count_path(conn, :show, count))
      |> render("show.json", count: count)
    end
  end

  def show(conn, %{"id" => id}) do
    count = Json.get_count!(id)
    render(conn, "show.json", count: count)
  end

  def update(conn, %{"id" => id, "count" => count_params}) do
    count = Json.get_count!(id)

    with {:ok, %Count{} = count} <- Json.update_count(count, count_params) do
      render(conn, "show.json", count: count)
    end
  end

  def delete(conn, %{"id" => id}) do
    count = Json.get_count!(id)
    with {:ok, %Count{}} <- Json.delete_count(count) do
      send_resp(conn, :no_content, "")
    end
  end

  def kill(conn, _) do
    SupervisorPhoenix.Counter.kill()
  end
end
