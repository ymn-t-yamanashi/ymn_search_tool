defmodule YmnToolWeb.SearchLive.IndexTest do
  use YmnToolWeb.ConnCase
  import Phoenix.LiveViewTest

  # https://hexdocs.pm/phoenix_live_view/Phoenix.LiveViewTest.html

  test "index", %{conn: conn} do
    {:ok, lv, html} = live(conn, ~p"/")
    assert html =~ "検索ワード"

    # 条件取り込み方法
    assert lv |> has_element?("#clear", "クリア(c)")
    assert lv |> has_element?("#getclip", "クリックボードから取得(p)")
    assert lv |> has_element?("#recognition", "音声認識(r)")

    # 条件
    assert lv |> has_element?("#q")
    assert lv |> has_element?("#question_type", "システム開発")
    assert lv |> has_element?("#llm_type", "質問")

    # 検索ページ
    assert lv |> has_element?("#link1", "hexdocs.pm/elixirで検索(1)")
    assert lv |> has_element?("#link8", "github.com Elixirコードで検索(8)")

    # LLM関連
    assert lv |> has_element?("#gemini", "geminiを起動(g)")
    assert lv |> has_element?("#llm", "Elixirについて質問")

    # 用語リスト
    assert lv
           |> has_element?(
             "div a.w-80.text-sm.rounded-lg.bg-cyan-800.px-2.m-1.text-white",
             "GKEにElixir環境構築"
           )
  end

  test "clear-click", %{conn: conn} do
    {:ok, lv, _html} = live(conn, ~p"/")

    # クリアボタンクリック
    assert lv
           |> element("form")
           |> render_change(%{q: "12s3"}) =~ "12s3"

    lv
    |> element("#clear")
    |> render_click()

    assert lv
           |> element("#q")
           |> render() =~ "value=\"\"/"
  end

  test "question_type", %{conn: conn} do
    {:ok, lv, _html} = live(conn, ~p"/")

    # 質問内容選択
    assert lv
           |> element("form")
           |> render_change(%{question_type: "Ubuntu"}) =~ "Ubuntu"

    assert lv
           |> element("#llm")
           |> render() =~ "Ubuntuについて質問"
  end

  test "llm_type", %{conn: conn} do
    {:ok, lv, _html} = live(conn, ~p"/")

    # LLM選択
    assert lv
           |> element("form")
           |> render_change(%{llm_type: "study"}) =~ "勉強方法"

    assert lv
           |> element("#llm")
           |> render() =~ "Elixirについて勉強方法を教えて"
  end

  test "click parlance", %{conn: conn} do
    {:ok, lv, _html} = live(conn, ~p"/")

    # 用語クリック
    assert lv
           |> element("div a[phx-value-parlance]:first-child")
           |> render_click() =~ "GKEにElixir環境構築"

    assert lv
           |> element("#q")
           |> render() =~ "GKEにElixir環境構築"

    assert lv
           |> element("#llm")
           |> render() =~ "GKEにElixir環境構築"
  end
end
