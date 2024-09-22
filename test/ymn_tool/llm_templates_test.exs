defmodule YmnTool.LlmTemplatesTest do
  use ExUnit.Case

  test "get_list" do
    expected = [
      {"question", "質問"},
      {"study", "勉強方法"},
      {"intention", "意図"}
    ]

    assert YmnTool.LlmTemplates.get_list() == expected
  end

  test "load" do
    ret = YmnTool.LlmTemplates.load("test/data/llm_templates_data.txt")
    assert 3 = ret |> Enum.count()
    assert %{key: "question", title: "質問", contents: contents} = ret |> List.first()
    assert contents =~ "質問。下記を日本語で教えてtest"
  end
end
