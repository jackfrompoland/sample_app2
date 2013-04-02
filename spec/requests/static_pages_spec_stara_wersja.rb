require 'spec_helper'

describe "Static pages" do
  
  describe "Home page" do
    before {visit root_path} #dzieki temu nie musimy pisac za kazdym razem, ze visitujemy 'root_path' <- opisane w pliku 'routes.rb' albo visit '/static_pages/home' 

    it "should have the h1 'Sample App'" do
      page.should have_selector('h1', text: 'Sample App')
    end
    it "should have the base title" do
      page.should have_selector('title',
                        text: "Ruby on Rails Tutorial Sample App")  #selector 'title' znajduje sie na 'application.html.erb' a tresc jest wypelniona w pliku 'application_helper.rb'
    end
    it "should not have a custom page title" do
      page.should_not have_selector('title', text: '| Home')
    end    
  end

  describe "Help page" do
    before {visit help_path}

    it "should have the h1 'Help'" do
      page.should have_selector('h1', text: 'Help')
    end
    it "should have the title 'Help'" do
      page.should have_selector('title',
                        text: "Ruby on Rails Tutorial Sample App | Help")
    end
  end

  describe "About page" do
    before {visit about_path}
    
    it "should have the h1 'About Us'" do
      page.should have_selector('h1', text: 'About Us')
    end

    it "should have the title 'About Us'" do
      page.should have_selector('title',
                    text: "Ruby on Rails Tutorial Sample App | About Us")
    end
  end
  
  describe "Contact page" do
    before {visit contact_path}
    
    it "should have the h1 'Contact'" do
      page.should have_selector('h1', text: 'Contact')
    end

    it "should have the title 'Contact'" do
      page.should have_selector('title',
                    text: "Ruby on Rails Tutorial Sample App | Contact")
    end
  end  
end