require 'spec_helper'


describe UserMailer do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @club = mock_model(Club, :name => "Test Club", :sub_domain => "www")
    @user = mock_model(User, :name => "Test User", :email => "foo@bar.com", :club => @club)
    @user.stub!(:confirm_token).and_return(SecureRandom.urlsafe_base64)
    @user.stub!(:reset_token).and_return(SecureRandom.urlsafe_base64)
  end


  describe "new_user_confirmation" do
    before do
      @mail = UserMailer.new_user_confirmation(@user).deliver
    end

    it "should be from rhodeproject@gmail.com" do
      @mail.from.should eq(["rhodeproject@gmail.com"])
    end

    it "should have a reply_to address of rhodeproject@gmail.com" do
      @mail.reply_to.should eq(["rhodeproject@gmail.com"])
    end

    describe "email body" do

      it "should contain the correct url" do
        @mail.body.should contain("www")
      end

      it "should contain the correct domain" do
        @mail.body.should contain("lvh.me:3000")
      end

      it "should contain a url from https" do
        @mail.body.should contain("https://")
      end

      it "should contain confirm token" do
        @mail.body.should contain(@user.confirm_token)
      end

    end

    it "should be sent to the correct user" do
      @mail.to.should eq([@user.email])
    end

    it "should have subject with club name" do
      @mail.subject.should contain(@club.name)
    end

  end

  describe "expiry_notice" do
    before do
      @mail = UserMailer.expiry_notice(@user).deliver
    end

    it "should be from rhodeproject@gmail.com" do
      @mail.from.should eq(["rhodeproject@gmail.com"])
    end

    it "should have a reply_to address of rhodeproject@gmail.com" do
      @mail.reply_to.should eq(["rhodeproject@gmail.com"])
    end

    describe "email body" do

      it "should contain the correct url" do
        @mail.body.should contain("www")
      end

      it "should contain the correct domain" do
        @mail.body.should contain("lvh.me:3000")
      end
    end

    it "should should be sent to correct user email" do
      @mail.to.should eq([@user.email])
    end

  end

  describe "event_reminder" do
    before do
      @event = mock_model(Event,
                         :title => "Test Event",
                         :starts_at => Date.today,
                         :ends_at => Date.today + 1,
                         :description => "some stuff",
                         :club => @club  )
      @mail = UserMailer.event_reminder(@user,@event).deliver

    end

    it "should be from rhodeproject@gmail.com" do
      @mail.from.should eq(["rhodeproject@gmail.com"])
    end

    it "should have a reply_to address of rhodeproject@gmail.com" do
      @mail.reply_to.should eq(["rhodeproject@gmail.com"])
    end

    it "should have a subject with event title" do
      @mail.subject.should contain(@event.title)
    end

    describe "email body" do
      it "should contain Event Title" do
        @mail.body.should contain(@event.title)
      end

      it "should contain the starts_at time" do
        @mail.body.should contain(@event.starts_at.to_s)
      end

      it "should contain the ends_at time" do
        @mail.body.should contain(@event.ends_at.to_s)
      end

      it "should contain the user name" do
        @mail.body.should contain(@user.name)
      end
    end

    it "should be sent to the email address of the correct user" do
      @mail.to.should eq([@user.email])
    end

  end

  describe "notice_email" do
    before do
      @emails = ["test1@foor.com", "test2@foo.com"]
      @mail = UserMailer.notice_email(@emails,"some content" ,@club.name)
    end

    it "should be from rhodeproject@gmail.com" do
      @mail.from.should eq(["rhodeproject@gmail.com"])
    end

    it "should have a reply_to address of rhodeproject@gmail.com" do
      @mail.reply_to.should eq(["rhodeproject@gmail.com"])
    end

    it "should blind copy emails array" do
      @mail.bcc.should eq(@emails)
    end

    describe "email body" do

      it "should contain the content" do
        @mail.body.should contain("some content")
      end

      it "should contain club name in the email body" do
        @mail.body.should contain(@club.name)
      end
    end

  end

  describe "password_reset" do
    before do
      @mail = UserMailer.password_reset(@user)

    end

    it "should be from rhodeproject@gmail.com" do
      @mail.from.should eq(["rhodeproject@gmail.com"])
    end

    describe "the body of the email" do

      it "should contain https://" do
        @mail.body.should contain("https://")
      end

      it "should contain club_url" do
        @mail.body.should contain(@club.sub_domain)
      end

      it "should contain rhodeproject.com" do
        @mail.body.should contain("rhodeproject.com")
      end

      it "should contain a reset token" do
        @mail.body.should contain(@user.reset_token)
      end

    end
  end

  describe "contact_email" do
    before do
      @club.stub!(:club_email).and_return("club_admin@foobar.com")
      @from_addr = "from@foobar.com"
      @from_name = "from test"
      @content = "some content"
      @mail = UserMailer.contact_email(@content, @from_addr, @from_name, @club.club_email)
    end

    it "should be from rhodeproject@gmail.com" do
      @mail.from.should eq(["rhodeproject@gmail.com"])
    end

    it "should be sent to club email" do
      @mail.to.should contain(@club.club_email)
    end

    it "should have a reply_to address of from_addr" do
      @mail.reply_to.should eq([@from_addr])
    end

    describe "email body" do

      it "should have some content" do
        @mail.body.should contain(@content)
      end


      it "should contain the senders name" do
        @mail.body.should contain(@from_name)
      end

    end


    it "should be from the user sending the email" do
      @mail.reply_to.should contain(@from_addr)
    end

    describe "the subject" do
      it "should contain the senders name" do
        @mail.subject.should contain(@from_name)
      end

      it "should contain the senders email address" do
        @mail.subject.should contain(@from_addr)
      end
    end

  end
end
