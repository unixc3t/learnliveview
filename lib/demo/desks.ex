defmodule Demo.Desks do
  @moduledoc """
  The Desks context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Desks.Desk

  @doc """
  Returns the list of desks.

  ## Examples

      iex> list_desks()
      [%Desk{}, ...]

  """
  def list_desks do
    Repo.all(Desk)
  end

  @doc """
  Gets a single desk.

  Raises `Ecto.NoResultsError` if the Desk does not exist.

  ## Examples

      iex> get_desk!(123)
      %Desk{}

      iex> get_desk!(456)
      ** (Ecto.NoResultsError)

  """
  def get_desk!(id), do: Repo.get!(Desk, id)

  @doc """
  Creates a desk.

  ## Examples

      iex> create_desk(%{field: value})
      {:ok, %Desk{}}

      iex> create_desk(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_desk(attrs \\ %{}) do
    %Desk{}
    |> Desk.changeset(attrs)
    |> Repo.insert()
  end

  def create_desk(%Desk{} = desk, attrs, fun) do
    desk
    |> Desk.changeset(attrs)
    |> Repo.insert()
    |> after_save(fun)
    |> broadcast(:desk_created)
  end

  defp after_save({:ok, desk}, fun) do
    {:ok, _desk} = fun.(desk)
  end
  defp after_save(error, _fun), do: error
  @doc """
  Updates a desk.

  ## Examples

      iex> update_desk(desk, %{field: new_value})
      {:ok, %Desk{}}

      iex> update_desk(desk, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_desk(%Desk{} = desk, attrs) do
    desk
    |> Desk.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a desk.

  ## Examples

      iex> delete_desk(desk)
      {:ok, %Desk{}}

      iex> delete_desk(desk)
      {:error, %Ecto.Changeset{}}

  """
  def delete_desk(%Desk{} = desk) do
    Repo.delete(desk)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking desk changes.

  ## Examples

      iex> change_desk(desk)
      %Ecto.Changeset{data: %Desk{}}

  """
  def change_desk(%Desk{} = desk, attrs \\ %{}) do
    Desk.changeset(desk, attrs)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Demo.PubSub, "desks")
  end

  def broadcast({:ok, desk}, event) do

    Phoenix.PubSub.broadcast(
      Demo.PubSub,
      "desks",
      {event, desk}
    )

    {:ok, desk}
  end
  def broadcast({:error, _reason} = error, _event), do: error

end
