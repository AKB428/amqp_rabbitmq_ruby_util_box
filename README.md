#AMQP RabbitMQ Ruby Util Script

RabbitMQを使ったユーティリティコード集です

https://www.rabbitmq.com/

## receive.rb

ポーリングしキューを受け取るサンプル

###  Body

[任意の文字列]

     AAAAAAAAAAAAAAAAA


## receive_download_url.rb

ポーリングし受け取ったキューURLをダウンロードするサンプル

### Body

[URL][SPACE][ダウンロードパス]

    http://i.imgur.com/rqFZVhq.jpg /Users/Siori/code/git_akb428/amqp_rabbitmq_ruby_util_box/private
    http://www.yuzu-soft.com/new/product/sothewitch/bin/sw_twitter.zip /Users/Siori/code/git_akb428/amqp_rabbitmq_ruby_util_box/private