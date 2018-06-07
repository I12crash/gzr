# frozen_string_literal: true

require 'thor'

module Gzr
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    class_option :debug, type: :boolean, default: false, desc: 'Run in debug mode'
    class_option :host, type: :string, default: 'localhost', desc: 'Looker Host'
    class_option :port, type: :string, default: '19999', desc: 'Looker API Port'
    class_option :client_id, type: :string, desc: 'API3 Client Id'
    class_option :client_secret, type: :string, desc: 'API3 Client Secret'
    class_option :api_version, type: :string, desc: 'Looker API Version'
    class_option :ssl, type: :boolean, default: true, desc: 'Use ssl to communicate with host'
    class_option :verify_ssl, type: :boolean, default: true, desc: 'Verify the SSL certificate of the host'
    class_option :force, type: :boolean, default: false, desc: 'Overwrite objects on server'
    class_option :su, type: :string, desc: 'After connecting, change to user_id given'


    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'gzr version'
    def version
      require_relative 'version'
      puts "v#{Gzr::VERSION}"
    end
    map %w(--version -v) => :version

    require_relative 'commands/attribute'
    register Gzr::Commands::Attribute, 'attribute', 'attribute [SUBCOMMAND]', 'Command description...'

    require_relative 'commands/plan'
    register Gzr::Commands::Plan, 'plan', 'plan [SUBCOMMAND]', 'Commands pertaining to plans'

    require_relative 'commands/group'
    register Gzr::Commands::Group, 'group', 'group [SUBCOMMAND]', 'Commands pertaining to groups'

    require_relative 'commands/model'
    register Gzr::Commands::Model, 'model', 'model [SUBCOMMAND]', 'Commands pertaining to LookML Models'

    require_relative 'commands/connection'
    register Gzr::Commands::Connection, 'connection', 'connection [SUBCOMMAND]', 'Commands pertaining to database connections and dialects'

    require_relative 'commands/user'
    register Gzr::Commands::User, 'user', 'user [SUBCOMMAND]', 'Commands pertaining to users'

    require_relative 'commands/dashboard'
    register Gzr::Commands::Dashboard, 'dashboard', 'dashboard [SUBCOMMAND]', 'Commands pertaining to dashboards'

    require_relative 'commands/look'
    register Gzr::Commands::Look, 'look', 'look [SUBCOMMAND]', 'Commands pertaining to looks'

    require_relative 'commands/space'
    register Gzr::Commands::Space, 'space', 'space [SUBCOMMAND]', 'Commands pertaining to spaces'
  end
end
