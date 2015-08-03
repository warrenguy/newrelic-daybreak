DependencyDetection.defer do
  @name = :daybreak

  depends_on do
    defined?(::Daybreak) &&
      !NewRelic::Control.instance['disable_daybreak'] &&
      ENV['NEWRELIC_ENABLE'].to_s !~ /false|off|no/i
  end

  executes do
    NewRelic::Agent.logger.info 'Installing Daybreak Instrumentation'
  end

  executes do
    require 'new_relic/agent/datastores'

    module NewRelicDaybreak::Instrumentation
      def [](key)
        NewRelic::Agent::Datastores.wrap("Daybreak", "get", key) do
          super(key)
        end
      end
      alias_method :get, '[]'

      def []=(key, value)
        NewRelic::Agent::Datastores.wrap("Daybreak", "set", key) do
          super(key, value)
        end
      end
      alias_method :set, '[]='

      def set!(key, value)
        NewRelic::Agent::Datastores.wrap("Daybreak", "set", key) do
          super(key, value)
        end
      end

      def delete(key) 
        NewRelic::Agent::Datastores.wrap("Daybreak", "delete", key) do
          super(key, value)
        end
      end

      def delete!(key)
        NewRelic::Agent::Datastores.wrap("Daybreak", "delete", key) do
          super(key, value)
        end
      end

      def update(*args)
        NewRelic::Agent::Datastores.wrap("Daybreak", "update", args.keys) do
          super(*args)
        end
      end
    end

    class Daybreak::DB
      prepend NewRelicDaybreak::Instrumentation
    end
  end
end
