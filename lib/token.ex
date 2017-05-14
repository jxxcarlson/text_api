defmodule TextApi.Token do

    import Joken

    @doc """
    Return a token with signed user_id and username
    """
    def get(user_id, username) do
      IO.puts "USER_ID: #{user_id}"
      # user = TextApi.Repo.get(TextApi.User, user_id)
      %{"user_id" => user_id, "username" => username}
      |> token
      |> with_validation("user_id", &(&1 == user_id))
      |> with_validation("username", &(&1 == username))
      |> with_signer(hs256("yada82043mU,@izq0#$mcq^&!HFQpnp8i-nc"))
      |> sign
      |> get_compact
    end

    @doc """
    Check to see that the token's signed user_id
    is the same as user_id.
    """
    defp validate(token, user_id) do
      token
      |> token
      |> with_validation("user_id", &(&1 == user_id))
      |> with_signer(hs256("yumpa80937173mU,@izq0#$mcq^&!HFQlkdfjonvueo,-+"))
      |> verify
    end

    @doc """
    Return true iff the token's signed user_id
    is the same as user_id.
    """
    def authenticated(token, user_id) do
      result = TextApi.Token.validate(token, user_id)
      result.error == nil
    end

end
