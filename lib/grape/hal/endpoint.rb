module Grape
  module Hal
    class Endpoint

      include Dsl

      attr_reader :entries, :context_path, :current_api

      def initialize(current_api, context_path)
        @current_api = current_api
        @context_path = context_path
        @entries = []
        add_self
      end

      def hal_for(path, options = {}, &block)
        entries << {
            path: path,
            rel: options[:rel],
            title: options[:title]
        }
        current_api.hal_for path, &block
      end

      def mount(api)
        api.endpoints.each do |endpoint|
          options = endpoint.options
          options[:path].each do |path|
            entries << {
                path: path,
                rel: options[:route_options][:rel],
                title: options[:route_options][:description]
            }
          end
        end
      end

      def generate_hal(base_path)
        hal_array = entries.map do |entry|
          key = entry[:rel] || entry[:path]

          value = {href: get_full_path(base_path, entry)}
          value[:title] = entry[:title] if entry[:title]
          value[:templated] = true if is_templated?(entry)
          [key, value]
        end
        {:_links => Hash[hal_array]}
      end

      private

      def add_self
        self_entry = {
            path: '',
            rel: 'self'
        }
        entries << self_entry
      end

      def get_full_path(base_path, entry)
        base_path = remove_parent_context_path(base_path) unless entry[:rel] === 'self'
        handle_path = parameterize(entry)
        File.join(base_path + handle_path)
      end

      def parameterize(entry)
        entry[:path].split('/').map do |segment|
          segment = '{' + segment[1..-1] + '}' if segment.start_with?(':')
          segment
        end.join('/')
      end

      def remove_parent_context_path(base_path)
        if base_path.end_with?(context_path)
          slice_to = base_path.rindex(context_path)
          base_path = base_path.slice(0, slice_to)
        end
        base_path
      end

      def is_templated?(entry)
        entry[:path].split('/').any? { |s| s.start_with?(':') }
      end

    end
  end
end
