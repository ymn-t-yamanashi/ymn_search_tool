defmodule YmnTool.LlmTemplatesTest do
  use ExUnit.Case

  test "get_list" do
    expected = [
      {"question", "質問"},
      {"study", "勉強方法"},
      {"intention", "意図"}
    ]

    llm_templates_data = YmnTool.LlmTemplates.load(get_llm_templates_path())

    assert YmnTool.LlmTemplates.get_list(llm_templates_data) == expected
  end

  test "load" do
    ret = YmnTool.LlmTemplates.load(get_llm_templates_path())
    assert 3 = ret |> Enum.count()
    assert %{key: "question", title: "質問", contents: contents} = ret |> List.first()
    assert contents =~ "質問"
  end

  test "get" do
    llm_templates_data = YmnTool.LlmTemplates.load(get_llm_templates_path())
    contents = YmnTool.LlmTemplates.get(llm_templates_data, "テスト", "Elixir", "question")
    assert contents =~ "Elixirについて質問"
    assert contents =~ "テスト"
  end

  defp get_llm_templates_path(), do: Application.get_env(:ymn_tool, :llm_templates_path)
end
