require 'spec_helper'

describe TasksController do
  render_views
#build(:user, :groups => [ build(:group, :group_name => 'Rails Developers') ])

  describe "for non-signed-in users" do
    before(:each) do
      @user = Factory(:user_with_task)
    end

    it "should deny access to 'index'" do
      get :index, :user_id => @user
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'show'" do
      get :show, :user_id => @user, :id => @user
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'new'" do
      get :new, :user_id => @user
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'create'" do
      post :create, :user_id => @user
      response.should redirect_to(signin_path)
    end

     it "should deny access to 'edit'" do
      get :edit, :user_id => @user, :id => @user
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'update'" do
      put :update, :user_id => @user, :id => @user
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :user_id => @user, :id => @user
      response.should redirect_to(signin_path)
    end
  end

describe "for signed-in users" do
  describe "GET 'index'" do

    before(:each) do
      @user = test_sign_in(Factory(:user_with_task))
    end

    it "successfuly" do
      get :index, :user_id => @user
      response.should render_template('tasks/index')
    end
  end

  describe "GET 'show'" do

    before(:each) do
      @user = test_sign_in(Factory(:user_with_task))
    end

    it "successfuly" do
      get :show, :user_id => @user, :id => @user.tasks.first
      response.should render_template('tasks/show')
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = {:title => "", :content => "" }
      end

      it "should not create a task" do
        lambda do
          post :create, :task => @attr, :user_id => @user
        end.should_not change(Task, :count)
      end

      it "should render the new task page" do
        post :create, :task => @attr, :user_id => @user
        response.should render_template('tasks/new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = Factory.attributes_for(:task)
      end

      it "should create a task" do
        lambda do
          post :create, :task => @attr, :user_id => @user
        end.should change(Task, :count).by(1)
      end

      it "should redirect to the task list page" do
        post :create, :task => @attr, :user_id => @user
        response.should redirect_to(user_tasks_path(:user_id => @user))
      end

      it "should have a flash message" do
        post :create, :task => @attr, :user_id => @user
        flash[:success].should =~ /task created/i
      end
    end
  end

  describe "PUT 'update'" do

    before(:each) do
      @user = test_sign_in(Factory(:user_with_task))
      @task = @user.tasks.first
    end

    describe "failure" do

      before(:each) do
        @attr = {:title => "", :content => "" }
      end

      it "should render the new task page" do
        put :update, :task => @attr, :user_id => @user, :id => @task
        response.should render_template('tasks/edit')
      end
    end

    describe "success" do

      before(:each) do
        @attr = Factory.attributes_for(:task)
      end

      it "should update a task" do
        put :update, :task => @attr, :user_id => @user, :id => @task
        @task.reload
        @task.title.should  == @attr[:title]
        @task.content.should == @attr[:content]

      end

      it "should redirect to the task list page" do
        put :update, :task => @attr, :user_id => @user, :id => @task
        response.should redirect_to(user_task_path(:user_id => @user, :id => @task))
      end

      it "should have a flash message" do
        put :update, :task => @attr, :user_id => @user, :id => @task
        flash[:success].should =~ /task updated/i
      end
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      @user = test_sign_in(Factory(:user_with_task))
      @task = @user.tasks.first
    end

    describe "success" do

      it "should create a task" do
        lambda do
          delete :destroy, :user_id => @user, :id => @task
        end.should change(Task, :count).by(-1)
      end

      it "should redirect to the task list page" do
        delete :destroy, :user_id => @user, :id => @task
        response.should redirect_to(user_tasks_path(:user_id => @user))
      end

      it "should have a flash message" do
        delete :destroy, :user_id => @user, :id => @task
        flash[:success].should =~ /destroyed/i
      end
    end
  end



end

end
