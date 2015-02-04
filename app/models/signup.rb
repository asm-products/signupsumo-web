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

  def first_name
    person.fetch(:name, {})[:given_name]
  end

  def details
    title || bio
  end

  def title
    return unless employment[:name].present?
    employment.values_at(:title, :name).compact.join(' at ')
  end

  def bio
    person[:bio]
  end

  def location
    person[:location]
  end

  def social
    handles = [:facebook, :github, :twitter, :linkedin, :googleplus, :angellist, :klout, :foursquare, :aboutme].map do |name|
      handle = person.fetch(name, {})[:handle]
      [name, handle] if handle.present?
    end.compact.to_h

    handles.map do |name, handle|
      url = case name
      when :facebook   then "https://facebook.com/#{handle}"
      when :github     then "https://github.com/#{handle}"
      when :twitter    then "https://twitter.com/#{handle}"
      when :linkedin   then "https://www.linkedin.com/#{handle}"
      when :googleplus then "https://plus.google.com/#{handle}"
      when :angellist  then "https://angel.co/#{handle}"
      when :klout      then "https://klout.com/#{handle}"
      when :foursquare then "https://foursquare.com/#{handle}"
      when :aboutme    then "https://about.me/#{handle}"
      end

      [name, url] if url
    end.compact.to_h
  end

  def avatar
    person[:avatar]
  end

  def grade
    case score
    when 1.0       then 'A+'
    when 0.9..1.0  then 'A'
    when 0.8..0.9  then 'B'
    when 0.7..0.8  then 'C'
    else                'F'
    end
  end

  def employment
    person.fetch(:employment, {}) || {}
  end

  def person
    data.fetch(:person, {}) || {}
  end

  def company
    data.fetch(:company, {}) || {}
  end

  def score
    data.fetch(:score, {}) || 0
  end

  def data
    super && super.deep_symbolize_keys
  end
end
