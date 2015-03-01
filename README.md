#AMQP RabbitMQ Ruby Util Script

RabbitMQを使ったユーティリティコード集です

https://www.rabbitmq.com/

## send.rb

Name:helloにキューを送るサンプル

### Name
    hello

### Body
    Hello World! (><)


## send_args.rb

引数でNameとキューメッセージを指定するサンプル

### Name
    ARGV[0]

### Body
    ARGV[1]

### コマンド例

    bundle exec ruby send_args.rb development.download_url 'http://i.imgur.com/EBjHCeH.jpg ./private'


## receive.rb

ポーリングしキューを受け取るサンプル

### Name
    development.download_url
### Body

[任意の文字列]

     AAAAAAAAAAAAAAAAA


## receive_download_url.rb

ポーリングし受け取ったキューURLをダウンロードするサンプル

### Name
    development.download_url

### Body

[URL][SPACE][ダウンロードパス]

    http://i.imgur.com/rqFZVhq.jpg /Users/Siori/code/git_akb428/amqp_rabbitmq_ruby_util_box/private
    http://www.yuzu-soft.com/new/product/sothewitch/bin/sw_twitter.zip /Users/Siori/code/git_akb428/amqp_rabbitmq_ruby_util_box/private

