require 'spec_helper'

describe Micropost do

  let(:user) { FactoryGirl.create(:user) }
  
  before { @micropost = user.microposts.build(content: "Lorem ipsum") }
  
  # before do
    # ten kod jest zly poniewaz umozliwia stworzenie usera o id, ktory juz istnieje
    # aby temu zapobiec w pliku 'micropost.rb' usuwamy dostep do ':user_id'
    # @micropost = Micropost.new(content: "Lorem ipsum", user_id: user.id)
  # end

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  

  it { should be_valid }

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
  # This test verifies that calling Micropost.new with a nonempty user_id raises a mass assignment security error exception. 
  # This behavior is on by default as of Rails 3.2.3, but previous versions had it off, so you should make sure that your 
  # application is configured properly, as shown in Listing 10.6.
  
  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end
    
end