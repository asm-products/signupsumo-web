class FreeSignup < Signup
  before_create :update_freebie_count

private

  def update_freebie_count
    self.user.update(freebie_count: self.user.freebie_count-1) if influential
  end
end
