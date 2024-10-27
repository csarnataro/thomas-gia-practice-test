defmodule ThomasGIAWeb.PageControllerTest do
  use ThomasGIAWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Increment"
  end
end
