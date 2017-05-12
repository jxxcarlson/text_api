# test/controllers/session_controller_test.exs
defmodule TextApi.SessionControllerTest do

  @@moduledoc """

  Create Session
  ==============

  Send a request `POST /api/vi/sessions` with body like

    {"email": "foo1@bar.com", "password": "s3cr3t"}

  The reply is like this:

    { "data": { "token": "YlplQzdqVVF2bDJyc2EyTzNTeW1iUT09" } }

  """
  use TextApi.ConnCase

  alias TextApi.Session
  alias TextApi.User
  @valid_attrs %{email: "foo@bar.com", password: "s3cr3t"}

  setup %{conn: conn} do
    changeset =  User.registration_changeset(%User{}, @valid_attrs)
    Repo.insert changeset
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: @valid_attrs
    assert token = json_response(conn, 201)["data"]["token"]
    assert Repo.get_by(Session, token: token)
  end

  test "does not create resource and renders errors when password is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: Map.put(@valid_attrs, :password, "notright")
    assert json_response(conn, 401)["errors"] != %{}
  end

  test "does not create resource and renders errors when email is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: Map.put(@valid_attrs, :email, "not@found.com")
    assert json_response(conn, 401)["errors"] != %{}
  end

end
