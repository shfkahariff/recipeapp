class Holiday < ApplicationRecord
    def start_time
        self.startholiday ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
    end

    def end_time
        self.endholiday ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
    end
end
