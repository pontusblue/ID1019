defmodule Phil do
  def start(0, _, _, name, ctrl) do
    send(ctrl, :done)
  end

  def start(hunger, right, left, name, ctrl) do
    spawn_link(fn -> timeForFood(hunger, right, left, name, ctrl) end)
  end

  def timeForFood(0, _, _, name, ctrl) do
    IO.puts("#{name} ate a little bit too much and will now rest...")
    send(ctrl, :done)
  end

  def timeForFood(hunger, right, left, name, ctrl) do

    # PICK UP LEFT
    case Chopstick.request(left, 200) do
      :granted ->
        IO.puts("#{name} picked up left")

        # PICK UP RIGHT
        case Chopstick.request(right, 200) do
        
            # EAT
          :granted ->
            IO.puts("#{name} picked up right")
            sleep(hunger * 100)
            Chopstick.return(right)
            Chopstick.return(left)
            IO.puts("#{name} returned")
            timeForFood(hunger - 1, right, left, name, ctrl)

            # GIVE UP WITH RIGHT
          :deny ->
            Chopstick.return(left)
            Chopstick.return(right)
            timeForFood(hunger, right, left, name, ctrl)
        end

        # GIVE UP WITH LEFT
      :deny ->
        Chopstick.return(left)
        timeForFood(hunger, right, left, name, ctrl)
    end
  end

  def sleep(0) do
    :ok
  end

  def sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end
end