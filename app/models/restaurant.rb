class Restaurant < ActiveRecord::Base
  # This is where the logic should go when you're doing things. 
  # You would either call these things in a controller or in a view.
  # The self methods are done in the controller
  # The instance methods are done when you're looping through the view.
  RATINGS = [1,2,3,4,5]
  FOOD_TYPES = ['Indian', 'Vegan', 'Chinese', 'Thai']
  belongs_to :city

  validates_presence_of :name, :food_type
  validates :food_type, inclusion: {in: FOOD_TYPES}
  validates :cost_rating, inclusion: {in: RATINGS}
  validates :open, :alcohol, :take_out, inclusion: {in: [true, false]}

  # class method on active record model is called a scope
  # Restaurant.all.by_name
  def self.by_name
    order(:name)
  end

  def self.by_cost
    order(:cost_rating)
  end

  def self.ratings
    RATINGS
  end

  def self.food_types
    FOOD_TYPES
  end
  # we also have instance methods:
  def status
    if self.open == true
      "The Restaurant: #{self.name} is open for business!"
    end
      "The Restaurant: #{self.name} opens very soon!"
  end
end
