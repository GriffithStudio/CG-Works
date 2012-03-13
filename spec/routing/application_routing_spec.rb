require "spec_helper"

describe ApplicationController do
  describe "routing" do
    
    it "routes to application#index" do
      get("/").should route_to("application#index")
    end
    
  end
end