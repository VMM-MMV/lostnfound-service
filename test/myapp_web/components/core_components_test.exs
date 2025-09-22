defmodule MyappWeb.CoreComponentsTest do
  use ExUnit.Case, async: true

  import MyappWeb.CoreComponents

  describe "translate_error/1" do
    test "translates a simple error message" do
      error = {"can't be blank", []}
      assert translate_error(error) == "can't be blank"
    end

    test "translates an error message with count option" do
      error = {"has invalid format", [count: 1]}
      assert translate_error(error) == "has invalid format"
    end

    test "translates an error message with a custom option" do
      error = {"is too short (minimum %{count} characters)", [count: 5]}
      assert translate_error(error) == "is too short (minimum 5 characters)"
    end
  end

  describe "translate_errors/2" do
    test "translates errors for a specific field" do
      errors = [
        {:email, {"can't be blank", []}},
        {:password, {"is too short", []}},
        {:email, {"has invalid format", []}}
      ]
      assert translate_errors(errors, :email) == ["can't be blank", "has invalid format"]
    end

    test "returns empty list if no errors for the field" do
      errors = [
        {:email, {"can't be blank", []}},
        {:password, {"is too short", []}}
      ]
      assert translate_errors(errors, :username) == []
    end

    test "handles empty error list" do
      assert translate_errors([], :email) == []
    end
  end
end
