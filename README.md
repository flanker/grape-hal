Grape Hal
=========

Description
-----------

A ruby gem which adds HAL support to ruby Grape Api.

HAL
---

HAL is a simple format that gives a consistent and easy way to hyperlink between resources in your API. See [HAL (Hyperlink Application Language)](http://stateless.co/hal_specification.html)

Ruby Grape
----------

github: [ruby grape api](https://github.com/intridea/grape)

Installation
------------

Install the gem by:

    gem install grape-hal

Or add the gem to your Gemfile

    gem 'grape-hal'

Use it in code by

    require 'grape/hal'

Examples
--------

If you want to add Hal response to your exist Grape Api, just simply include `Grape::Hal` and then use the dsl to describe your Apis.

Here are some Grape Apis. Note the `include Grape::Hal` and `hal_for` block.

```ruby
require 'grape/hal'

class FooApi < ::Grape::API
  desc 'foo api description', rel: 'foo api'
  get '/foo_path/'
end

class SubApi < ::Grape::API
  desc 'bar api description with {param}', rel: 'bar api'
  get 'bar_path/:param'

  desc 'qux api description', rel: 'qux api'
  get 'qux_path'
end

class BazApi < ::Grape::API

  include Grape::Hal

  mount FooApi
  mount SubApi

  hal_for '/' do
    hal_for '/sub', rel: 'sub', title: 'a sub api module' do
      mount SubApi
    end
    mount FooApi
  end

end
```

After this, when a http request to specific path with `json` format accept headers.

    GET / HTTP/1.1
    Accept: application/hal+json, application/json, */*; q=0.01

`grape/hal` will response with the Hal data for you.

    HTTP/1.1 200 OK
    Content-Type: application/hal+json

    {
      "_links": {
        "self": {
          "href": "/"
        },
        "sub": {
          "href": "/sub",
          "title": "a sub api module"
        },
        "foo api": {
          "href": "/foo_path",
          "title": "foo api description"
        }
      }
    }

Footer
------

Feng Zhichao flankerfc(at)gmail.com

