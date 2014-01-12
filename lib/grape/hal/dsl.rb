module Grape
  module Hal
    module Dsl

      def hal_for(context_path, &block)
        content_type :json, 'application/hal+json'

        endpoint = Endpoint.new self, context_path
        endpoint.instance_eval(&block)

        get context_path do
          base_url = env['PATH_INFO']
          content_type 'application/hal+json'
          endpoint.generate_hal base_url
        end
      end

    end
  end
end