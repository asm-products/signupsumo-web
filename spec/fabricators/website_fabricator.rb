Fabricator(:website) do
  user { Fabricate (:user) }  
  name { 'Some SaaS app' }
  host {'http://example.com' }
end
