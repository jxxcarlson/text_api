defmodule TextApi.Repo do
  use Ecto.Repo, otp_app: :text_api

  alias TextApi.Document

  @alba """
As cool as the pale wet leaves
     of lily-of-the-valley
She lay beside me in the dawn.
"""

  @metro """
The apparition of these faces in the crowd;
     Petals on a wet, black bough.
     """
  @pact """
I make a pact with you, Walt Whitman--
              I have detested you long enough.
              I come to you as a grown child
              Who has had a pig-headed father;
              I am old enough now to make friends.
              It was you that broke the new wood,
              Now is a time for carving.
              We have one sap and one root--
              Let there be commerce between us.
              """

  def x_all(Document) do
    [
      %Document{id: 1, title: "Alba",  text: @alba},
      %Document{id: 2, title: "Metro", text: @metro},
      %Document{id: 3, title: "A Pact", text: @pact}
    ]
  end

end
