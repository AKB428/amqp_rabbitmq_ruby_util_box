#AMQP RabbitMQ Ruby Util Script

RabbitMQを使ったユーティリティコード集です

https://www.rabbitmq.com/

## send.rb

Name:helloにキューを送るサンプル

| Property     | Value               |
| :------------ | :------------------ |
| Name         | hello              |
| Body         | Hello World! (><)  |

## send_args.rb

引数でNameとキューメッセージを指定するサンプル

| Property     | Value               |
| :------------ | :------------------ |
| Name         | ARGV[0]              |
| Body         | ARGV[1]  |

### コマンド例

    bundle exec ruby send_args.rb development.download_url 'http://i.imgur.com/EBjHCeH.jpg ./private'


## receive.rb

ポーリングしキューを受け取るサンプル


| Property     | Value               |Sample|
| :------------ | :------------------ |:-------|
| Name         | development.download_url||
| Body         | 任意の文字列|AAAAAAAAAAAA|

## receive_args_name.rb

引数で指定したNameをポーリングしキューを受け取るサンプル


| Property     | Value               |Sample|
| :------------ | :------------------ |:-------|
| Name         | ARGV[0]|twitter.streaming.all|
| Body         | 任意の文字列|AAAAAAAAAAAA|


## receive_download_url.rb

ポーリングし受け取ったキューURLをダウンロードするサンプル

| Property     | Value               |Sample|
| :------------ | :------------------ |:-------|
| Name         | development.download_url|
| Body         | [URL][SPACE][ダウンロードパス]  |http://i.imgur.com/rqFZVhq.jpg /Users/Siori/code/git_akb428/amqp_rabbitmq_ruby_util_box/private|

## receive_object_strage_queue.rb

OpenStack Object Strage Send Queue Sample

| Property     | Value               |Sample|
| :------------ | :------------------ |:-------|
| Name         | development.send_object_strage|
| Body         | JSON_Body  ||

JSON Body

| Property     | Value               |Sample|
| :------------ | :------------------ |:-------|
| dest_path         | object strage dest container path| /container0001 |
| src_path         | src file path or src folder path  | /home/niko/hogehoge.txt |

JSON Body Sample

```
{
  "dest_path": "/test",
  "src_path": "./private/EBjHCeH.jpg"
}
```
command

	bundle exec ruby receive_object_strage_queue.rb

送信側のコマンド、サンプル

	bundle exec ruby send_args.rb development.send_object_strage '{"dest_path":"/test", "src_path":"./private/EBjHCeH.jpg"}'


