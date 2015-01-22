module ProfileHelper

  Clearbit.key = "0ce37f6767aa10faeca517b6296431b4"

  def find_profile email
    if profile = Profile.find_by_email(email)
      return profile
    else
      profile = new_profile(email)
    end
  end

  def new_profile email
    profile = Clearbit::Person.find(email: email)

    if profile
      profile = Profile.create(email: email, data: profile.to_s)
    else
      profile = Profile.create(email: email, data: nil)
    end
  end

end
