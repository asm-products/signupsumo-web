class Signup < ActiveRecord::Base
  belongs_to :user

  validates :email,
    presence: true,
    uniqueness: { scope: :user_id }

  validates :user_id,
    presence: true

  def name
    person.fetch(:name, {})[:full_name]
  end

  def details
    title || bio
  end

  def title
    return unless employment &&
      employment[:name] &&
      employment[:title]

    "#{employment[:title]} at #{employement[:name]}"
  end

  def bio
    person[:bio]
  end

  def location
    person[:location]
  end

  def followers
    person.fetch(:twitter, {})[:followers]
  end

  def employment
    person.fetch(:employment, {})
  end

  def person
    data.fetch(:person, {})
  end

  def company
    data.fetch(:company, {})
  end

  def score
    data.fetch(:score, {})
  end

  def data
    super.symbolize_keys
  end
end
