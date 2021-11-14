defmodule Timemanager.DataTest do
  use Timemanager.DataCase

  alias Timemanager.Data


  describe "users" do
    alias Timemanager.Data.User

    import Timemanager.DataFixtures

    @invalid_attrs %{address: nil, city: nil, country: nil, email: nil, firstname: nil, lastname: nil, role: nil, zipcode: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Data.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Data.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{address: "some address", city: "some city", country: "some country", email: "some email", firstname: "some firstname", lastname: "some lastname", role: "some role", zipcode: "some zipcode"}

      assert {:ok, %User{} = user} = Data.create_user(valid_attrs)
      assert user.address == "some address"
      assert user.city == "some city"
      assert user.country == "some country"
      assert user.email == "some email"
      assert user.firstname == "some firstname"
      assert user.lastname == "some lastname"
      assert user.role == "some role"
      assert user.zipcode == "some zipcode"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{address: "some updated address", city: "some updated city", country: "some updated country", email: "some updated email", firstname: "some updated firstname", lastname: "some updated lastname", role: "some updated role", zipcode: "some updated zipcode"}

      assert {:ok, %User{} = user} = Data.update_user(user, update_attrs)
      assert user.address == "some updated address"
      assert user.city == "some updated city"
      assert user.country == "some updated country"
      assert user.email == "some updated email"
      assert user.firstname == "some updated firstname"
      assert user.lastname == "some updated lastname"
      assert user.role == "some updated role"
      assert user.zipcode == "some updated zipcode"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_user(user, @invalid_attrs)
      assert user == Data.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Data.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Data.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Data.change_user(user)
    end
  end

  describe "workingtimes" do
    alias Timemanager.Data.Workingtime

    import Timemanager.DataFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      workingtime = workingtime_fixture()
      assert Data.list_workingtimes() == [workingtime]
    end

    test "get_workingtime!/1 returns the workingtime with given id" do
      workingtime = workingtime_fixture()
      assert Data.get_workingtime!(workingtime.id) == workingtime
    end

    test "create_workingtime/1 with valid data creates a workingtime" do
      valid_attrs = %{end: ~N[2021-11-02 14:12:00], start: ~N[2021-11-02 14:12:00]}

      assert {:ok, %Workingtime{} = workingtime} = Data.create_workingtime(valid_attrs)
      assert workingtime.end == ~N[2021-11-02 14:12:00]
      assert workingtime.start == ~N[2021-11-02 14:12:00]
    end

    test "create_workingtime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_workingtime(@invalid_attrs)
    end

    test "update_workingtime/2 with valid data updates the workingtime" do
      workingtime = workingtime_fixture()
      update_attrs = %{end: ~N[2021-11-03 14:12:00], start: ~N[2021-11-03 14:12:00]}

      assert {:ok, %Workingtime{} = workingtime} = Data.update_workingtime(workingtime, update_attrs)
      assert workingtime.end == ~N[2021-11-03 14:12:00]
      assert workingtime.start == ~N[2021-11-03 14:12:00]
    end

    test "update_workingtime/2 with invalid data returns error changeset" do
      workingtime = workingtime_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_workingtime(workingtime, @invalid_attrs)
      assert workingtime == Data.get_workingtime!(workingtime.id)
    end

    test "delete_workingtime/1 deletes the workingtime" do
      workingtime = workingtime_fixture()
      assert {:ok, %Workingtime{}} = Data.delete_workingtime(workingtime)
      assert_raise Ecto.NoResultsError, fn -> Data.get_workingtime!(workingtime.id) end
    end

    test "change_workingtime/1 returns a workingtime changeset" do
      workingtime = workingtime_fixture()
      assert %Ecto.Changeset{} = Data.change_workingtime(workingtime)
    end
  end

  describe "clocks" do
    alias Timemanager.Data.Clock

    import Timemanager.DataFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Data.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Data.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~N[2021-11-02 14:13:00]}

      assert {:ok, %Clock{} = clock} = Data.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~N[2021-11-02 14:13:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~N[2021-11-03 14:13:00]}

      assert {:ok, %Clock{} = clock} = Data.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2021-11-03 14:13:00]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_clock(clock, @invalid_attrs)
      assert clock == Data.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Data.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Data.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Data.change_clock(clock)
    end
  end
end
