class Movie < ActiveRecord::Base
  @@ALL_RATINGS = ['G','PG','PG-13','R','NC-17']
  def self.ALL_RATINGS
    @@ALL_RATINGS
  end
end
