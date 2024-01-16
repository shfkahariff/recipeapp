module ApplicationHelper
    def format_duration(days)
        "#{days} #{'day'.pluralize(days)}"
    end
end
