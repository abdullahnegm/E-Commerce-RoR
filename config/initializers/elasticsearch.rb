require 'elasticsearch/model'

Elasticsearch::Model.client = Elasticsearch::Client.new host: '192.168.1.12:9200', 
                              log: true, transport_options: { request: { open_timeout: 1 } }