defmodule Timemanager.Data do
  @moduledoc """
  The Data context.
  """

  import Ecto.Query, warn: false
  alias Timemanager.Repo
  alias Timemanager.Guardian
  alias Timemanager.Data.User
  import Comeonin.Bcrypt

  # def token_sign_in(email, password) do
  #   case email_password_auth(email, password) do
  #     {:ok, user} ->
  #       Guardian.encode_and_sign(user)

  #     _ ->
  #       {:error, :unauthorized}
  #   end
  # end
  def authenticate_user(email, password) do
    query = from u in User, where: u.email == ^email

    case Repo.one(query) do
      nil ->
        Bcrypt.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Bcrypt.verify_pass(password, user.password_hash) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  # defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
  #   with {:ok, user} <- get_by_email(email),
  #        do: verify_password(password, user)
  # end

  # defp get_by_email(email) when is_binary(email) do
  #   case Repo.get_by(User, email: email) do
  #     nil ->
  #       dummy_checkpw()
  #       {:error, "Login error."}

  #     user ->
  #       {:ok, user}
  #   end
  # end

  # defp verify_password(password, %User{} = user) when is_binary(password) do
  #   if Bcrypt.verify_pass(password, user.password_hash) do
  #     {:ok, user}
  #   else
  #     {:error, :invalid_password}
  #   end
  # end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias Timemanager.Data.Workingtime

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtime{}, ...]

  """
  def promote(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def list_workingtimes do
    Repo.all(Workingtime)
  end

  @doc """
  Gets a single workingtime.

  Raises `Ecto.NoResultsError` if the Workingtime does not exist.

  ## Examples

      iex> get_workingtime!(123)
      %Workingtime{}

      iex> get_workingtime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workingtime!(id), do: Repo.get!(Workingtime, id)

  def list_workingtimes_by_user(user_id) do
    query = from(w in Workingtime, where: w.user == ^user_id)
    Repo.all(query)
  end

  def list_workingtimes_by_user_and_id(user_id, id) do
    query = from(w in Workingtime, where: w.user == ^user_id and w.id == ^id)
    Repo.all(query)
  end

  def list_workingtimes_schedule(userid, startTime, endTime) do
    query =
      from(m in Workingtime,
        where: m.user == ^userid and m.start >= ^startTime and m.end <= ^endTime
      )

    Repo.all(query)
  end

  @doc """
  Creates a workingtime.

  ## Examples

      iex> create_workingtime(%{field: value})
      {:ok, %Workingtime{}}

      iex> create_workingtime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workingtime(attrs \\ %{}) do
    %Workingtime{}
    |> Workingtime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a workingtime.

  ## Examples

      iex> update_workingtime(workingtime, %{field: new_value})
      {:ok, %Workingtime{}}

      iex> update_workingtime(workingtime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtime(%Workingtime{} = workingtime, attrs) do
    workingtime
    |> Workingtime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a workingtime.

  ## Examples

      iex> delete_workingtime(workingtime)
      {:ok, %Workingtime{}}

      iex> delete_workingtime(workingtime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtime(%Workingtime{} = workingtime) do
    Repo.delete(workingtime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtime changes.

  ## Examples

      iex> change_workingtime(workingtime)
      %Ecto.Changeset{data: %Workingtime{}}

  """
  def change_workingtime(%Workingtime{} = workingtime, attrs \\ %{}) do
    Workingtime.changeset(workingtime, attrs)
  end

  alias Timemanager.Data.Clock

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clock{}, ...]

  """
  def list_clocks do
    Repo.all(Clock)
  end

  @doc """
  Gets a single clock.

  Raises `Ecto.NoResultsError` if the Clock does not exist.

  ## Examples

      iex> get_clock!(123)
      %Clock{}

      iex> get_clock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clock!(id), do: Repo.get!(Clock, id)

  @doc """
  Creates a clock.

  ## Examples

      iex> create_clock(%{field: value})
      {:ok, %Clock{}}

      iex> create_clock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clock(attrs \\ %{}) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clock.

  ## Examples

      iex> update_clock(clock, %{field: new_value})
      {:ok, %Clock{}}

      iex> update_clock(clock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clock.

  ## Examples

      iex> delete_clock(clock)
      {:ok, %Clock{}}

      iex> delete_clock(clock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clock(%Clock{} = clock) do
    Repo.delete(clock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.

  ## Examples

      iex> change_clock(clock)
      %Ecto.Changeset{data: %Clock{}}

  """
  def change_clock(%Clock{} = clock, attrs \\ %{}) do
    Clock.changeset(clock, attrs)
  end

  alias Timemanager.Data.Team

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    Repo.all(Team)
  end


  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id)

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{data: %Team{}}

  """
  def change_team(%Team{} = team, attrs \\ %{}) do
    Team.changeset(team, attrs)
  end

  alias Timemanager.Data.Managing
  def list_managing_team(teamId) do
    query=from m in Managing, where: m.teamId == ^teamId
    Repo.all(query)
  end

  def list_managing_manager(managerId) do
    query=from m in Managing, where: m.employeeId == ^managerId, where: m.isManager == true
    Repo.all(query)
  end
  @doc """
  Returns the list of managing.

  ## Examples

      iex> list_managing()
      [%Managing{}, ...]

  """
  def list_managing do
    Repo.all(Managing)
  end

  @doc """
  Gets a single managing.

  Raises `Ecto.NoResultsError` if the Managing does not exist.

  ## Examples

      iex> get_managing!(123)
      %Managing{}

      iex> get_managing!(456)
      ** (Ecto.NoResultsError)

  """
  def get_managing!(id) do
    query=from m in Managing, where: m.employeeId == ^id, where: m.isManager == true
    user = Repo.all(query)
    IO.inspect(user)
    if (!is_nil(user)) do
      teams = for usr <- user, do: usr.teamId
      query=from m in Managing, where: m.teamId in ^teams, where: m.isManager == false
      Repo.all(query)
    else
      []
    end

  end
  @doc """
  Creates a managing.

  ## Examples

      iex> create_managing(%{field: value})
      {:ok, %Managing{}}

      iex> create_managing(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_managing(attrs \\ %{}) do
    %Managing{}
    |> Managing.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a managing.

  ## Examples

      iex> update_managing(managing, %{field: new_value})
      {:ok, %Managing{}}

      iex> update_managing(managing, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_managing(%Managing{} = managing, attrs) do
    managing
    |> Managing.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a managing.

  ## Examples

      iex> delete_managing(managing)
      {:ok, %Managing{}}

      iex> delete_managing(managing)
      {:error, %Ecto.Changeset{}}

  """
  def delete_managing(%Managing{} = managing) do
    Repo.delete(managing)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking managing changes.

  ## Examples

      iex> change_managing(managing)
      %Ecto.Changeset{data: %Managing{}}

  """
  def change_managing(%Managing{} = managing, attrs \\ %{}) do
    Managing.changeset(managing, attrs)
  end
end
