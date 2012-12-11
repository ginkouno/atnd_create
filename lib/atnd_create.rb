# -*- encoding: utf-8 -*-
require "atnd_create/version"

module AtndCreate
  class AtndCreateException < Exception; end

  class Event
    attr_accessor :account_id, :password, :title, :sub_title, :body, :start, :end, :limit, :url, :place_name, :address, :login_method
    attr_reader :posted

    GOOGLE_LOGIN_URL = 'https://www.google.com/accounts/Login?hl=en&continue=http://www.google.com/'
    ATND_BETA_LOGIN_URL = 'http://atnd.org/login/google'

    def initialize(account_id, password, option = {:login_type => :google})
      @login_method = "login_#{option[:login_type].to_s}"
      raise AtndCreate::AtndCreateException, "#{option[:login_type]}でのloginには対応していません。" unless Event.method_defined?(@login_method)

      @account_id = account_id
      @password = password

      @posted = false
    end

    def created?
      @posted
    end

    def login_google(agent)
      agent.get( GOOGLE_LOGIN_URL )

      form = agent.page.form
      form.Email = @account_id
      form.Passwd = @password
      agent.submit(form)

      # Todo: Check login success?

      agent
    end

    def post
      return @result_uri if @posted
      agent = Mechanize.new

      agent = eval(@login_method, agent)

      # access ATND beta
      agent.get(ATND_BETA_LOGIN_URL)

      # Todo: Check login success?

      # ATNDへのログインに成功したかチェック
      form = agent.page.form
  # attend forms
  #[text:0x1062c18 type: text name: event[title] value: ]
  #[text:0x1062a74 type: text name: event[catch] value: ]
  #[text:0x10628e4 type: text name: event_started_at value: ]
  #[text:0x1062740 type: text name: event_started_at_time value: ]
  #[text:0x10625ec type: text name: event_ended_at value: ]
  #[text:0x1062498 type: text name: event_ended_at_time value: ]
  #[text:0x1062344 type: text name: event[limit] value: ]
  #[text:0x10621c8 type: text name: event[place] value: ]
  #[text:0x106204c type: text name: event[address] value: ]
  #[text:0x1061ed0 type: text name: event[url] value: http://]
  #[text:0x10617dc type: text name: event[recommended_twitter_account] value: ]
  #[text:0x106164c type: text name: event[hash_tag] value: ]
  #[textarea:0x121e174 type:  name: event[description] value: ]}

      form["event[title]"] = @title
      form["event[description]"]  = @discription
      form["event_started_at"] = "2012-12-31"
      form["event_started_at_time"] = "10:00"

      agent.submit(form)

      @posted = true

      @result_uri = agent.history.last.uri.to_s

      @result_url
    end
  end
end
