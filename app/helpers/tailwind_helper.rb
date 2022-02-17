module TailwindHelper
  def auth_input_area
    "field w-full px-10 py-1"
  end

  def auth_input
    "px-1 bg-transparent border-b focus:bg-white focus:outline-none focus:duration-700 w-full"
  end

  def auth_submit
    "px-2 text-white hover:bg-white hover:text-black hover:duration-700"
  end

  def auth_form
    "container px-10"
  end

  def auth_full_screen
    "flex flex-1 flex-col items-center justify-center bg-black/90 h-screen opacity-80"
  end

  def auth_main_contents_container
    "flex basis-3/4 justify-center lg:basis-1/2 border"
    # "flex basis-3/4 justify-center lg:basis-1/2"
  end

  def auth_main_contents
    "flex flex-col w-full items-center py-2"
  end
end
