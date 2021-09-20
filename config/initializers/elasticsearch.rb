require 'elasticsearch/model'

Elasticsearch::Model.client = Elasticsearch::Client.new log: true, 
                                                        transport_options: {request: {open_timeout: 5}}
