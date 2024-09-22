defmodule YmnToolWeb.SearchLive.IndexTest do
  use YmnToolWeb.ConnCase
  import Phoenix.LiveViewTest

  test "index", %{conn: conn} do
    {:ok, _lv, html} = live(conn, ~p"/")
    assert html =~ "検索ワード"
  end
end
