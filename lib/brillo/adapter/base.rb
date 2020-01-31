module Brillo
  module Adapter
    class Base
      include Logger

      attr_reader :config
      def initialize(db_config)
        @config = db_config
      end
      def header
        ActiveRecord::Base.connection.dump_schema_information
      end

      def footer
        ""
      end

      def table_footer(klass)
        ""
      end

      def dump_structure_and_migrations(path)
        # Overrides the path the structure is dumped to in Rails >= 3.2
        ENV['SCHEMA'] = ENV['DB_STRUCTURE'] = path
        Rake::Task["db:structure:dump"].invoke
      end

      def load_command
        raise NotImplementedError
      end

      def recreate_db
        ["db:drop", "db:create"].each do |t|
          logger.info "Running\n\trake #{t}"
          Rake::Task[t].invoke
        end
      end
    end
  end
end
