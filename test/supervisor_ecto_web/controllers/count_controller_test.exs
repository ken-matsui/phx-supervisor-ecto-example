defmodule SupervisorEctoWeb.CountControllerTest do
  use SupervisorEctoWeb.ConnCase

  alias SupervisorEcto.Json
  alias SupervisorEcto.Json.Count

  @create_attrs %{count: 42}
  @update_attrs %{count: 43}
  @invalid_attrs %{count: nil}

  def fixture(:count) do
    {:ok, count} = Json.create_count(@create_attrs)
    count
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all counts", %{conn: conn} do
      conn = get conn, count_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create count" do
    test "renders count when data is valid", %{conn: conn} do
      conn = post conn, count_path(conn, :create), count: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, count_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "count" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, count_path(conn, :create), count: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update count" do
    setup [:create_count]

    test "renders count when data is valid", %{conn: conn, count: %Count{id: id} = count} do
      conn = put conn, count_path(conn, :update, count), count: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, count_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "count" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, count: count} do
      conn = put conn, count_path(conn, :update, count), count: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete count" do
    setup [:create_count]

    test "deletes chosen count", %{conn: conn, count: count} do
      conn = delete conn, count_path(conn, :delete, count)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, count_path(conn, :show, count)
      end
    end
  end

  defp create_count(_) do
    count = fixture(:count)
    {:ok, count: count}
  end
end
