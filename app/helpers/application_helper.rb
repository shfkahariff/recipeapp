module ApplicationHelper
    include Pagy::Frontend
    def format_duration(days)
        "#{days} #{'day'.pluralize(days)}"
    end

    def user_color(user_id)
        colors = {
          16 => "yellow-100",
          17 => "blue-100",
          6 => "green-100",
            7 => "red-100",
            8 => "pink-100",
            9 => "purple-100",
            18 => "indigo-100",
            19 => "yellow-100",
            20 => "blue-100",
            21 => "green-100",
          # Add more colors as needed
        }
        colors[user_id] || "gray-100" # Default to gray if user_id is not in the hash
    end
end
