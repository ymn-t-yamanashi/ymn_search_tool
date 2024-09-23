defmodule YmnTool.LlmTemplatesTest do
  use ExUnit.Case

  test "get_list" do
    expected = [
      {"question", "質問"},
      {"study", "勉強方法"},
      {"intention", "意図"}
    ]

    llm_templates_data = YmnTool.LlmTemplates.load("test/data/llm_templates_data.txt")

    assert YmnTool.LlmTemplates.get_list(llm_templates_data) == expected
  end

  test "load" do
    ret = YmnTool.LlmTemplates.load("test/data/llm_templates_data.txt")
    assert 3 = ret |> Enum.count()
    assert %{key: "question", title: "質問", contents: contents} = ret |> List.first()
    assert contents =~ "質問"
  end

  test "get" do
    llm_templates_data = YmnTool.LlmTemplates.load("test/data/llm_templates_data.txt")
    contents = YmnTool.LlmTemplates.get(llm_templates_data, "テスト", "Elixir", "question")
    assert contents =~ "Elixirについて質問"
    assert contents =~ "テスト"
  end
end
