require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/message_posts/show.html.erb" do
  include MessagePostsHelper

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs.merge({:is_admin? => true, :name => "dude", :full_name => 'Dude McDuder',
          :email => "a@b"}))
  end

  before(:each) do
    @forum = stub_model(Forum, :title => "The Forum")
    assign(:forum, @forum)
    @child_posts = [
        stub_model(MessagePost, :subject => 'messsub1', :body => 'messbody', 
          :user => mock_user, :created_at => 5.days.ago, :updated_at => 3.days.ago),
        stub_model(MessagePost, :subject => 'messsub2', :body => 'messbody',
          :user => mock_user, :created_at => 15.days.ago, :updated_at => 13.days.ago)
      ].paginate :page => 1, :per_page => 2
    assign(:child_posts, @child_posts)
    @message_post = stub_model(MessagePost,
      :subject => "value for subject",
      :body => "value for body",
      :created_at => 5.days.ago,
      :updated_at => 3.days.ago,
      :forum => @forum,
      :user => mock_user,
      :thread_id => 1
    )
    assign(:message_post, @message_post)
    view.stub!(:current_user).and_return(mock_user)
  end

  it "renders attributes in some page not really used I think" do
    render
    rendered.should =~ (/value\ for\ subject/)
    rendered.should =~ (/value\ for\ body/)
  end
end
